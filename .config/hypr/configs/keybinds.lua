-- keybinds
-- visit https://wiki.hypr.land/Configuring/Basics/Binds/ for more info

local home = os.getenv("HOME")

local mainMod = "SUPER"

-- defaults apps
local browser = "librewolf"
local files = "thunar"
local term = "kitty"

-- directories
local scriptsDir = home .. "/.config/hypr/scripts"

-------------------------------------------------
-- DEFAULT APPS & EXIT
-------------------------------------------------

hl.bind(mainMod .. " + Q", hl.dsp.window.close())
hl.bind(mainMod .. " + F", hl.dsp.window.fullscreen({ mode = "fullscreen", action = "toggle" }))
hl.bind(mainMod .. " + SHIFT + Q", hl.dsp.window.kill())
hl.bind(mainMod .. " + SHIFT + F", hl.dsp.window.float({ action = "toggle"}))

hl.bind("CTRL + ALT + Delete", hl.dsp.exit())
hl.bind("CTRL + ALT + L", hl.dsp.exec_cmd(scriptsDir .. "/LockScreen.sh"))
hl.bind("CTRL + ALT + P", hl.dsp.exec_cmd("wleave"))

-------------------------------------------------
-- FEATURES / EXTRAS
-------------------------------------------------

hl.bind(mainMod .. " + H", hl.dsp.exec_cmd(scriptsDir .. "/KeyHints.sh"))
hl.bind(mainMod .. " + ALT + R", hl.dsp.exec_cmd(scriptsDir .. "/Refresh.sh"))
hl.bind(mainMod .. " + ALT + E", hl.dsp.exec_cmd(scriptsDir .. "/RofiEmoji.sh"))
hl.bind(mainMod .. " + S", hl.dsp.exec_cmd(scriptsDir .. "/RofiSearch.sh"))
hl.bind(mainMod .. " + SHIFT + G", hl.dsp.exec_cmd(scriptsDir .. "/GameMode.sh"))
hl.bind(mainMod .. " + ALT + V", hl.dsp.exec_cmd(scriptsDir .. "/ClipManager.sh"))
hl.bind(mainMod .. " + SHIFT + N", hl.dsp.exec_cmd("swaync-client -t -sw"))
hl.bind(mainMod .. " + E", hl.dsp.exec_cmd(scriptsDir .. "/QuickEdit.sh"))
hl.bind(mainMod .. " + W", hl.dsp.exec_cmd(scriptsDir .. "/WallpaperSelect.sh"))
hl.bind("CTRL + ALT + W", hl.dsp.exec_cmd(scriptsDir .. "/WallpaperRandom.sh"))

-------------------------------------------------
-- WAYBAR / BAR RELATED
-------------------------------------------------

hl.bind(mainMod .. " + B", hl.dsp.exec_cmd("killall -SIGUSR1 waybar"))

-------------------------------------------------
-- VOLUME CONTROLS (XF86 keys)
-------------------------------------------------

hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd(scriptsDir .. "/Volume.sh --inc"))
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd(scriptsDir .. "/Volume.sh --dec"))
hl.bind("XF86AudioMute", hl.dsp.exec_cmd(scriptsDir .. "/Volume.sh --toggle"))
hl.bind(mainMod .. " + XF86AudioMute", hl.dsp.exec_cmd(scriptsDir .. "/Volume.sh --toggle-mic"))

-------------------------------------------------
-- SCREENSHOTS
-------------------------------------------------

hl.bind("Print", hl.dsp.exec_cmd(scriptsDir .. "/ScreenShot.sh --area"))
hl.bind(mainMod .. " + Print", hl.dsp.exec_cmd(scriptsDir .. "/ScreenShot.sh --now"))
hl.bind(mainMod .. " + CTRL + Print", hl.dsp.exec_cmd(scriptsDir .. "/ScreenShot.sh --in5"))
hl.bind(mainMod .. " + ALT + Print", hl.dsp.exec_cmd(scriptsDir .. "/ScreenShot.sh --in10"))
hl.bind(mainMod .. " + SHIFT + S", hl.dsp.exec_cmd(scriptsDir .. "/ScreenShot.sh --swappy"))

-------------------------------------------------
-- ROFI LAUNCHER
-------------------------------------------------

-- Note: bindr (repeatable) equivalent in Lua
hl.bind(mainMod .. " + SUPER_L", hl.dsp.exec_cmd("pkill rofi || rofi -show drun"), { release = true })
hl.bind(mainMod .. " + D", hl.dsp.exec_cmd("pkill rofi || rofi -show drun"))

-------------------------------------------------
-- TERMINAL & FILES & BROWSER
-------------------------------------------------

hl.bind(mainMod .. " + Return", hl.dsp.exec_cmd(term))
hl.bind(mainMod .. " + T", hl.dsp.exec_cmd(files))
hl.bind(mainMod .. " + I", hl.dsp.exec_cmd(browser))

-------------------------------------------------
-- RESIZE WINDOWS (elastic/bound)
-------------------------------------------------

hl.bind(mainMod .. " + SHIFT + Left", hl.dsp.window.resize({ x = -10, y = 0, relative = true}), { repeating = true })hl.bind(mainMod .. " + SHIFT + Right", hl.dsp.window.resize({ x = 10, y = 0, relative = true}), { repeating = true })
hl.bind(mainMod .. " + SHIFT + Up", hl.dsp.window.resize({ x = 0, y = 10, relative = true}), { repeating = true })
hl.bind(mainMod .. " + SHIFT + Down", hl.dsp.window.resize({ x = 0, y = -10, relative = true}), { repeating = true })
-------------------------------------------------
-- MOVE WINDOWS
-------------------------------------------------

hl.bind(mainMod .. " + CTRL + Left", hl.dsp.window.move({ direction = "l" }))
hl.bind(mainMod .. " + CTRL + Right", hl.dsp.window.move({ direction = "r" }))
hl.bind(mainMod .. " + CTRL + Up", hl.dsp.window.move({ direction = "u" }))
hl.bind(mainMod .. " + CTRL + Down", hl.dsp.window.move({ direction = "d" }))

-------------------------------------------------
-- MOVE FOCUS
-------------------------------------------------

hl.bind(mainMod .. " + Left", hl.dsp.focus({ direction = "l" }))
hl.bind(mainMod .. " + Right", hl.dsp.focus({ direction = "r" }))
hl.bind(mainMod .. " + Up", hl.dsp.focus({ direction = "u"}))
hl.bind(mainMod .. " + Down", hl.dsp.focus({ direction = "d"}))

-------------------------------------------------
-- WORKSPACES
-------------------------------------------------

hl.bind(mainMod .. " + tab", hl.dsp.focus( { workspace = "e+1" }))
hl.bind(mainMod .. " + SHIFT + tab", hl.dsp.focus( { workspace = "e-1" }))

-- switch to workspaces 1-10 using keycodes
for i = 1, 10 do
    local numberkey = { 10, 11, 12, 13, 14, 15, 16, 17, 18, 19 }
    hl.bind(mainMod .. " + code:" .. numberkey[i], function()
        hl.dispatch(hl.dsp.focus({ workspace = i }))
    end)
end

-- Move window to workspace 1-10
--#/# bind = SUPER+ALT, Hash,, -- Send to workspace -- (1, 2, 3,...)
for i = 1, 10 do
    hl.bind(mainMod .. " + SHIFT + " .. (i % 10), function()
        hl.dispatch(hl.dsp.window.move({ workspace = i, follow = false }))
    end, { description = "Window: Send to workspace " .. i })
end

-------------------------------------------------
-- MOUSE BINDS (Move/Resize)
-------------------------------------------------

hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(), { mouse = true }) -- Super + LMB: move window
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true }) -- Super + RMB: resize window

