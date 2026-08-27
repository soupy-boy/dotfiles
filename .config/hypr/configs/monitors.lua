-- monitors
-- https://wiki.hypr.land/Configuring/Basics/Monitors/
-- Configure your Display resolution, offset, scale and Monitors here, use `hyprctl monitors` to get the info.

-- with hdmi 1080p monitor
hl.monitor({ output = "DP-3", mode = "2560x1440@165", position = "0x0", scale = 1})
hl.monitor({ output = "HDMI-A-1", mode = "1920x1080@144", position = "2560x0", scale = 1})

-- with dp 1080p monitor
--hl.monitor({ output = "DP-2", mode = "1920x1080@60", position = "2560x0", scale = 1})

