-- environment variables

-- clutter
hl.env("CLUTTER_BACKEND", "wayland")

-- cursor (size defaults to 24)
-- hl.env("XCURSOR_THEME", "")
-- hl.env("XCURSOR_SIZE", "")

-- gdk
hl.env("GDK_BACKEND", "wayland,x11")

-- qt
hl.env("QT_AUTO_SCREEN_SCALE_FACTOR", "1")
hl.env("QT_QPA_PLATFORM", "wayland;xcb")
hl.env("QT_QPA_PLATFORMTHEME", "qt5ct")
hl.env("QT_SCALE_FACTOR", "1")
hl.env("QT_WAYLAND_DISABLE_WINDOWDECORATION", "1")

-- xdg
hl.env("XDG_CURRENT_DESKTOP", "Hyprland")
hl.env("XDG_SESSION_DESKTOP", "Hyprland")
hl.env("XDG_SESSION_TYPE", "wayland")

-- sdl (for cs2)
hl.env("SDL_VIDEO_DRIVER", "wayland")

-- vulkan
hl.env("WLR_RENDERER", "vulkan")

-- firefox
hl.env("MOZ_ENABLE_WAYLAND", "1")

-- electron
hl.env("ELECTRON_OZONE_PLATFORM_HINT", "auto")

-- NVIDIA 
-- This is from Hyprland Wiki https://wiki.hypr.land/Nvidia/. As a start, WLR_NO_HARDWARE_CURSORS 1 will be activated if nvidia gpu detected
hl.env("LIBVA_DRIVER_NAME", "nvidia")
hl.env("__GLX_VENDOR_LIBRARY_NAME", "nvidia")
hl.env("GBM_BACKEND", "nvidia-drm")

