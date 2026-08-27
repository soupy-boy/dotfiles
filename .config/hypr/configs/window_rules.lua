-- window rules

-- browser tags
hl.window_rule({ match = { class = "^([Ll]ibrewolf)$" }, tag ="+browser" })

-- notif tags
hl.window_rule({ match = { class = "^(swaync-control-center|swaync-notification-window|swaync-client|class)$" }, tag = "+notif" })

-- KooL settings tag (yad)
hl.window_rule({ match = { class = "^(yad)$" }, tag = "+KooL_Cheat" })

-- terminal tags
hl.window_rule({ match = { class = "^(kitty)$" }, tag = "+terminal" })

-- email tags
hl.window_rule({ match = { class = "^([Tt]hunderbird|org.mozilla.Thunderbird)$" }, tag = "+email" })
hl.window_rule({ match = { class = "^(tutanota-desktop)$" }, tag = "+email" })

-- project tags
hl.window_rule({ match = { class = "^(code)$" }, tag = "+projects" })

-- IM tags (instant messenger)
hl.window_rule({ match = { title = "^([Dd]iscord|[Ww]ebCord|[Vv]esktop)$" }, tag = "+im" })

-- game tags
hl.window_rule({ match = { class = "^(gamescope)$" }, tag = "+games" })
hl.window_rule({ match = { class = "^(steam_app_\\d+)$" }, tag = "+games" })
hl.window_rule({ match = { title = "^(steam_app_\\d+)$" }, tag = "+games" })
hl.window_rule({ match = { class = "^(steam_app_default)$" }, tag = "+games" })
hl.window_rule({ match = { class = "^(cs2)" }, tag = "+games" })
hl.window_rule({ match = { title = "^([Mm]egabonk)" }, tag = "+games" })
hl.window_rule({ match = { title = "^([Ii]nscryption)" }, tag = "+games" })
hl.window_rule({ match = { class = "^(Stardew Valley)" }, tag = "+games" })
hl.window_rule({ match = { class = "^(Hollow Knight Silksong)" }, tag = "+games" })
hl.window_rule({ match = { class = "^(SevTech Ages)" }, tag = "+games" })
hl.window_rule({ match = { class = "^(Slay the Spire)" }, tag = "+games" })
hl.window_rule({ match = { class = "^(hl2_linux)" }, tag = "+games" })
hl.window_rule({ match = { title = "^(Barony)" }, tag = "+games" })
hl.window_rule({ match = { title = "^(Kerbal Space Program)" }, tag = "+games" })
hl.window_rule({ match = { title = "^(Getting Over It)" }, tag = "+games" })

-- gamestore tags
hl.window_rule({ match = { class = "^([Ss]team)$" }, tag = "+gamestore" })
hl.window_rule({ match = { title = "^([Ll]utris)$" }, tag = "+gamestore" })

-- file-manager tags
hl.window_rule({ match = { class = "^[Tt]hunar$" }, tag = "+file-manager" })

-- settings tags
hl.window_rule({ match = { class = "^pavucontrol|org.pulseaudio.pavucontrol|com.saivert.pwvucontrol$" }, tag = "+settings" })
hl.window_rule({ match = { class = "^qt5ct|qt6ct|[Yy]ad$" }, tag = "+settings" })
hl.window_rule({ match = { class = "xdg-desktop-portal-gtk" }, tag = "+settings" })
hl.window_rule({ match = { class = "^org.kde.polkit-kde-authentication-agent-1$" }, tag = "+settings" })
hl.window_rule({ match = { class = "^[Rr]ofi$" }, tag = "+settings" })


-- POSITION RULES
-- KooL_Cheat centers on
hl.window_rule({ match = { tag = "KooL_Cheat" }, center = true })

-- Thunar specific: Center if title does NOT contain "Thunar" (avoids main window centering)
-- Note: 'negative:' prefix in old conf is handled by adding 'negative:' to the regex string in Lua match
hl.window_rule({ match = { class = "^[Tt]hunar$", title = "negative:.*[Tt]hunar.*" }, center = true })

-- Pavucontrol centers on
hl.window_rule({ match = { class = "^pavucontrol|org.pulseaudio.pavucontrol|com.saivert.pwvucontrol$" }, center = true })

-- steam sign in center on screen, centers on
hl.window_rule({ match = { title = "Sign in to Steam" }, center = true })

-- Picture-in-Picture moves to 72% width, 7% height
hl.window_rule({ match = { title = "^Picture-in-Picture$" }, move = { "monitor_w * 0.72", "monitor_h * 0.07" } })

-- IDLE INHIBIT (Avoid idle for fullscreen apps)
hl.window_rule({ match = { fullscreen = true }, idle_inhibit = "fullscreen" })

-- FLOAT RULES
-- Tag-based floats
hl.window_rule({ match = { tag = "KooL_Cheat" }, float = true })
hl.window_rule({ match = { tag = "settings" }, float = true })

-- Specific App Floats
hl.window_rule({ match = { class = "^mpv|com.github.rafostar.Clapper$" }, float = true })
hl.window_rule({ match = { title = "^Picture-in-Picture$" }, float = true })

-- Popups & Dialogues (Floating + Optional Center/Size)
-- Authentication Required
hl.window_rule({ match = { title = "^Authentication Required$" }, float = true, center = true })

-- Steam Non-Steam Window (e.g. overlays) - Float only
hl.window_rule({ match = { class = "^[Ss]team$", title = "negative:^([Ss]team)$" }, float = true })

-- Thunar Non-Thunar Window - Float only
hl.window_rule({ match = { class = "^[Tt]hunar$", title = "negative:.*[Tt]hunar.*" }, float = true })

-- Size Specific Floats
local sizeOpts = { "monitor_w * 0.7", "monitor_h * 0.6" }
hl.window_rule({ match = { title = "^Add Folder to Workspace$" }, float = true, size = sizeOpts, center = true })
hl.window_rule({ match = { title = "^Save As$" }, float = true, size = sizeOpts, center = true })
-- Open Files (No center specified in original, just size)
hl.window_rule({ match = { initial_title = "^Open Files$" }, float = true, size = sizeOpts })

-- OPACITY RULES
-- Format: "active inactive [fullscreen]"
-- Use "override" to set absolute value instead of multiplying global opacity
hl.window_rule({ match = { tag = "browser" }, opacity = "0.99 override 0.8 override" })
hl.window_rule({ match = { tag = "projects" }, opacity = "0.9 override 0.8 override" })
hl.window_rule({ match = { tag = "im" }, opacity = "0.94 override 0.86 override" })
hl.window_rule({ match = { tag = "file-manager" }, opacity = "0.9 override 0.8 override" })
hl.window_rule({ match = { tag = "terminal" }, opacity = "0.9 override 0.7 override" })
hl.window_rule({ match = { tag = "settings" }, opacity = "0.8 override 0.7 override" })

-- Specific Text Editors
hl.window_rule({ match = { class = "^gedit|org.gnome.TextEditor|mousepad$" }, opacity = "0.8 override 0.7 override" })
hl.window_rule({ match = { title = "^Picture-in-Picture$" }, opacity = "0.95 override 0.75 override" })

-- SIZE RULES (Non-floating specific sizes, though usually applied to floating too)
hl.window_rule({ match = { tag = "KooL_Cheat" }, size = { "monitor_w * 0.65", "monitor_h * 0.9" } })
hl.window_rule({ match = { tag = "settings" }, size = { "monitor_w * 0.7", "monitor_h * 0.7" } })

-- PINNING RULES
hl.window_rule({ match = { title = "^Picture-in-Picture$" }, pin = true, keep_aspect_ratio = true })

-- BLUR & FULLSCREEN RULES
hl.window_rule({ match = { tag = "games" }, no_blur = true })
hl.window_rule({ match = { tag = "games" }, fullscreen = true }) -- Force fullscreen mode
hl.window_rule({ match = { tag = "games" }, confine_pointer = true })

-- WORKSPACE RULES
hl.window_rule({ match = { tag = "games" }, workspace = "5" })
hl.window_rule({ match = { tag = "gamestore" }, workspace = "6", no_initial_focus = true })
hl.window_rule({ match = { tag = "im" }, workspace = "6", no_initial_focus = true })

-- LAYER RULES (Blurring popups like Rofi/SwayNC)
-- Note: Layer rules use hl.layer_rule()
hl.layer_rule({ match = { namespace = "rofi" }, blur = true })
hl.layer_rule({ match = { namespace = "notifications" }, blur = true })

