# LibreWolf — Gruvbox Dark Hard (manual CSS theme)

No extension. These files are tracked in the dotfiles repo and symlinked from
the LibreWolf profile directory.

## Files

- `user.js` — sets `toolkit.legacyUserProfileCustomizations.stylesheets = true`
- `chrome/userChrome.css` — browser UI (toolbar, urlbar, tabs, popups, sidebar)
- `chrome/userContent.css` — new tab / home pages

Palette: `#1d2021` frame, `#32302f` toolbar, `#ebdbb2` text, `#a89984` secondary,
`#689d6a` accent (tab line / loading).

## Per-machine setup (after cloning the dotfiles repo)

Profiles are named `<hash>.default-release`, so the profile path is machine
specific. The profile dir needs these symlinks (relative, so `$HOME` doesn't
matter):

```sh
PROFILE=~/.librewolf/*.default-release
ln -s ../../.config/librewolf/user.js  "$PROFILE/user.js"
ln -s ../../.config/librewolf/chrome  "$PROFILE/chrome"
```

Then fully restart LibreWolf. Remove the files (or flip the pref in
`about:config`) to undo.