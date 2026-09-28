#!/bin/bash
# used https://github.com/cwadge/ge-proton-updater as reference to make latest update logic
# MIT license
# Updates GE-Proton into a single stable Steam tool directory, so the tool
# Steam has on record never changes and updates need no Steam config edits.
#
# Usage:
#   ./protonge_update.sh              install the latest release (no-op if current)
#   ./protonge_update.sh --rollback   swap back to the previous release
#
# Run --rollback with Steam closed.
set -euo pipefail
trap 'echo "Error" >&2' ERR

# Make a temporary working directory
echo "Making sure temporary directory exists..."
mkdir -p /tmp/proton-ge-custom
cd /tmp/proton-ge-custom

steam_dir=~/.steam/steam

# --- Stable Steam tool identity -------------------------------------------
# Steam binds a game (and the global default, appid 0) to the compat tool
# NAME declared in compatibilitytool.vdf. Extracting into version-named
# directories (GE-Proton11-7-x86_64) therefore orphans that binding on the
# next update, which is why the tool has to be re-picked in Steam each time.
#
# Instead we install into one fixed directory with one fixed internal name and
# display name, and swap the build *inside* it. The name Steam has stored never
# changes, so updates need no Steam config edit and no Steam restart.
LATEST_DIR="GE-Proton-Latest"       # directory name under compatibilitytools.d
LATEST_INTERNAL="GE-Proton-Latest"  # internal name in compatibilitytool.vdf
LATEST_DISPLAY="Proton GE Latest"   # label shown in Steam's dropdown
VERSION_FILE=".ge-proton-version"   # records which build is installed inside

# The build that was in place before the last update is kept here, so a bad
# update can be rolled back with './protonge_update.sh --rollback'. It gets the
# same stable-identity treatment as Latest, so the rollback is a directory swap
# plus a restart of Steam -- no download, no re-picking the tool in any game's
# settings. Only one generation is kept.
PREVIOUS_DIR="GE-Proton-Previous"
PREVIOUS_INTERNAL="GE-Proton-Previous"
PREVIOUS_DISPLAY="Proton GE Previous"

# Write the manifest that registers a directory with Steam under a fixed name.
# Defined before --rollback below, which is the first thing that calls it.
write_manifest() {
    local dir="$1" internal_name="$2" display_name="$3"
    cat > "$dir/compatibilitytool.vdf" <<VDFEOF
"compatibilitytools"
{
  "compat_tools"
  {
    "$internal_name"
    {
      "install_path"  "."
      "display_name"  "$display_name"
      "from_oslist"   "windows"
      "to_oslist"     "linux"
    }
  }
}
VDFEOF
}

# --rollback swaps Latest and Previous instead of installing an update. Steam
# must be closed while this runs, since it rewrites the tool manifests that
# Steam may have cached in memory.
if [[ "${1:-}" == "--rollback" ]]; then
    compat_dir="$steam_dir/compatibilitytools.d"
    install_dir="$compat_dir/$LATEST_DIR"
    previous_dir="$compat_dir/$PREVIOUS_DIR"

    if [[ ! -d "$previous_dir" ]]; then
        echo "Error: No $PREVIOUS_DIR to roll back to." >&2
        exit 1
    fi

    echo "Rolling back $LATEST_DIR and $PREVIOUS_DIR..."
    swap_dir="$compat_dir/.ge-rollback.$$"
    mv "$install_dir" "$swap_dir" 2>/dev/null || true
    mv "$previous_dir" "$install_dir"
    mv "$swap_dir" "$previous_dir" 2>/dev/null || true

    # Swap the manifests too, so each directory keeps a name matching its role.
    write_manifest "$install_dir" "$LATEST_INTERNAL" "$LATEST_DISPLAY"
    write_manifest "$previous_dir" "$PREVIOUS_INTERNAL" "$PREVIOUS_DISPLAY"

    echo "Rolled back. '$LATEST_DISPLAY' is now $(cat "$install_dir/$VERSION_FILE" 2>/dev/null || echo unknown)."
    echo "Restart Steam to pick it up."
    exit 0
fi

# Verify Steam data directory exists
if [[ ! -d "$steam_dir" ]]; then
    echo "Error: Steam (native) data directory not found." >&2
    echo "Please launch Steam at least once to populate it." >&2
    exit 1
fi

# Make a Steam compatibility tools folder if it does not exist
compat_dir="$steam_dir/compatibilitytools.d"
install_dir="$compat_dir/$LATEST_DIR"
mkdir -p "$compat_dir"

# Fetch release info
echo "Fetching release info..."
release_json=$(curl -s --max-time 10 \
    https://api.github.com/repos/GloriousEggroll/proton-ge-custom/releases/latest)

if [[ -z "$release_json" || "$release_json" != *'"tag_name"'* ]]; then
    echo "Error: Failed to fetch release info from GitHub." >&2
    exit 1
fi

# Resolve release URL for current architecture
echo "Fetching release for your arch..."

case "$(uname -m)" in
    aarch64|arm64) tarball_pattern='GE-Proton[0-9]+-[0-9]+\-aarch64\.tar\.gz$' ;;
    x86_64)        tarball_pattern='GE-Proton[0-9]+-[0-9]+\-x86_64\.tar\.gz$' ;;
    *)
        echo "Error: Unsupported architecture: $(uname -m)." >&2
        echo "GE-Proton is only available for x86_64 and aarch64." >&2
        exit 1
        ;;
esac

tarball_url=$(echo "$release_json" |
    grep browser_download_url |
    cut -d\" -f4 |
    grep -E "$tarball_pattern" |
    head -n1 || true)

tarball_name=$(basename "$tarball_url")
release_name=${tarball_name%.tar.gz}

if [[ -z "$tarball_url" ]]; then
    echo "Error: Could not find a matching release for your arch ($(uname -m))." >&2
    exit 1
fi

# Skip if this exact build is already installed. The directory name no longer
# encodes the version, so the build is read from the state file instead.
installed_version=""
if [[ -f "$install_dir/$VERSION_FILE" ]]; then
    installed_version=$(cat "$install_dir/$VERSION_FILE")
fi

if [[ "$installed_version" == "$release_name" ]]; then
    echo "Latest release $release_name is already installed as '$LATEST_DISPLAY'."
    exit 0
fi

# Resolve checksum URL
checksum_url=$(echo "$release_json" |
    grep browser_download_url |
    cut -d\" -f4 |
    grep "$release_name.sha512sum$" || true)

if [[ -z "$checksum_url" ]]; then
    echo "Error: Could not find a checksum for $tarball_name in the release." >&2
    exit 1
fi

# Use cached tarball from tmp if valid, resume if incomplete
if [[ -f "$tarball_name" ]]; then
    echo "Found cached release: $release_name"
    echo "Verifying download..."

    if curl -sL "$checksum_url" | sha512sum -c - &>/dev/null; then
        echo "Cached release OK, skipping download."
    else
        echo "Cached release is incomplete, resuming download..."
        curl -C - -L "$tarball_url" -o "$tarball_name" --progress-bar
        echo "Verifying download..."

        if ! curl -sL "$checksum_url" | sha512sum -c - &>/dev/null; then
            echo "Resumed download corrupt, falling back to fresh download..."
            rm -f "$tarball_name"
            curl -L "$tarball_url" -o "$tarball_name" --progress-bar
            echo "Verifying download..."

            if ! curl -sL "$checksum_url" | sha512sum -c -; then
                echo "Error: Verification failed! The downloaded release may be corrupt." >&2
                exit 1
            fi
        fi
    fi

# Nuke the temporary working directory and download the tarball
else
    echo "Cleaning temporary directory..."
    rm -rf /tmp/proton-ge-custom
    mkdir /tmp/proton-ge-custom
    cd /tmp/proton-ge-custom
    echo "Downloading release: $release_name..."
    curl -L "$tarball_url" -o "$tarball_name" --progress-bar
    echo "Verifying download..."

    if ! curl -sL "$checksum_url" | sha512sum -c -; then
        echo "Error: Verification failed! The downloaded release may be corrupt." >&2
        exit 1
    fi
fi

# --- Install into the stable tool directory -------------------------------
# Stage first, then swap with a rename. A failed download, corrupt tarball or
# interrupted run can never leave a broken Proton behind: the existing install
# stays in place until a complete, validated build is ready to take its place.
staging_dir="$compat_dir/.ge-staging.$$"
rm -rf "$staging_dir" 2>/dev/null || true   # clear a stale dir from an interrupted run
mkdir -p "$staging_dir"

echo "Extracting $tarball_name to a staging directory..."
tar -xzf "$tarball_name" -C "$staging_dir" \
    || { echo "Error: Extraction failed!" >&2; rm -rf "$staging_dir"; exit 1; }

# Find the build's top-level directory inside the tarball rather than assuming
# it equals the release tag, then sanity check that it really is a Proton build.
staged_root=$(find "$staging_dir" -mindepth 1 -maxdepth 1 -type d | head -n1)
if [[ -z "$staged_root" ]]; then
    echo "Error: Tarball did not contain a top-level build directory." >&2
    rm -rf "$staging_dir"
    exit 1
fi

if [[ ! -f "$staged_root/proton" ]]; then
    echo "Error: Extracted build is missing the 'proton' entry point." >&2
    rm -rf "$staging_dir"
    exit 1
fi

# Retire the outgoing build into Previous before Latest is overwritten, so there
# is always a known-good build to fall back on. Only one generation is kept, and
# the drop happens here -- after the new build is staged and validated -- so a
# failure earlier in this run never costs you the old copy.
previous_dir="$compat_dir/$PREVIOUS_DIR"
retired_version=""
if [[ -f "$install_dir/$VERSION_FILE" ]]; then
    retired_version=$(cat "$install_dir/$VERSION_FILE")
fi

if [[ -n "$retired_version" ]]; then
    if [[ -d "$previous_dir" ]]; then
        rm -rf "$previous_dir" \
            || { echo "Error: Could not clear the existing $PREVIOUS_DIR." >&2; rm -rf "$staging_dir"; exit 1; }
    fi
    mv "$install_dir" "$previous_dir" \
        || { echo "Error: Could not rotate $LATEST_DIR to $PREVIOUS_DIR." >&2; rm -rf "$staging_dir"; exit 1; }
    write_manifest "$previous_dir" "$PREVIOUS_INTERNAL" "$PREVIOUS_DISPLAY"
    echo "$retired_version" > "$previous_dir/$VERSION_FILE"
    echo "Rotated $retired_version to '$PREVIOUS_DISPLAY' (rollback copy)."
else
    # Nothing usable to retire; make sure no stale Previous lingers.
    rm -rf "$previous_dir" 2>/dev/null || true
fi

# Move the staged build into Latest. Both paths are on the same filesystem, so
# this is a rename rather than a copy.
mv "$staged_root" "$install_dir" \
    || { echo "Error: Could not install the new build." >&2
         if [[ -d "$previous_dir" ]]; then
             mv "$previous_dir" "$install_dir"   # put the retired build back
             write_manifest "$install_dir" "$LATEST_INTERNAL" "$LATEST_DISPLAY"
         fi
         rm -rf "$staging_dir"; exit 1; }

rm -rf "$staging_dir" 2>/dev/null || true

write_manifest "$install_dir" "$LATEST_INTERNAL" "$LATEST_DISPLAY"
echo "$release_name" > "$install_dir/$VERSION_FILE"

echo "Installed $release_name as '$LATEST_DISPLAY' (~/.steam/steam/compatibilitytools.d/$LATEST_DIR)."
echo "Done :)"
