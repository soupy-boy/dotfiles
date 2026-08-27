-- settings
-- https://wiki.hypr.land/Configuring/Basics/Variables/

hl.config({
-- pretend hyprland supports full CM (HDR) for gamescope/other wayland apps
    debug = { 
        full_cm_proto = true,
    },
    dwindle = {
        preserve_split = true,
    }, 
    ecosystem = {
        no_donation_nag = true,
        no_update_news = true
    },
    general = {
        gaps_in = 4,
        gaps_out = 8,
        border_size = 2,
        resize_on_border = true,
   
        col = {
	    active_border = { colors = {"rgba(d79921cc)", "rgba(689d6acc)"}, angle = 45 },
            inactive_border = { colors = {"rgba(458588cc)", "rgba(b16286cc)"}, angle = 45},
        },

        layout = "dwindle",
    },

    group = {
        col = {
	    border_active = { colors = {"rgba(d79921cc)", "rgba(689d6acc)"}, angle = 45},
            border_inactive = { colors = {"rgba(458588cc)", "rgba(b16286cc)"}, angle = 45},
            border_locked_active = { colors = {"rgba(d79921cc)", "rgba(689d6acc)"}, angle = 45},
            border_locked_inactive = { colors = {"rgba(458588cc)", "rgba(b16286cc)"}, angle = 45},
	},
    },
    decoration = {
        rounding = 8,
         
        active_opacity = 1.0,
        inactive_opacity = 0.9,
        fullscreen_opacity = 1.0,

        dim_inactive = true,
        dim_strength = 0.1,

        shadow = {
            enabled = true,
            range = 6,
            render_power = 1,
        },

        blur = {
            enabled = true,
            size = 5,
            passes = 2,
            ignore_opacity = true,
            new_optimizations = true,
        },
    },
    animations = {
        enabled = true,
    },
    input = {
        kb_layout="us",
        repeat_rate=50,
        repeat_delay=300,

        sensitivity = 0.0, -- mouse sensitivity - acceleration
        numlock_by_default=true,
        left_handed=true,
        follow_mouse=1,
        float_switch_override_focus=0,
    },

    misc = {
        disable_hyprland_logo = true,
        disable_splash_rendering = true,
        mouse_move_enables_dpms = true,
        key_press_enables_dpms = true,
        enable_swallow = true,
        focus_on_activate = false,
        swallow_regex = "^(kitty)$",
        allow_session_lock_restore = true, -- Prevent lockscreen crash when resume from suspend
    },

    binds = {
        workspace_back_and_forth=true,
        allow_workspace_cycles=true,
        pass_mouse_when_bound=false,
    },

    -- Could help when scaling and not pixelating
    xwayland = {
        force_zero_scaling = true,
    },
})

-- curves for animating
hl.curve("linear",   { type = "bezier", points = { {0.0, 0.0}, {1.0, 1.0} } })
hl.curve("wind",     { type = "bezier", points = { {0.05, 0.9}, {0.1, 1.05} } })
hl.curve("winOut",   { type = "bezier", points = { {0.3, -0.3}, {0, 1} } })
hl.curve("slow",     { type = "bezier", points = { {0, 0.85}, {0.3, 1} } })
hl.curve("overshot", { type = "bezier", points = { {0.7, 0.6}, {0.1, 1.1} } })
hl.curve("bounce",   { type = "bezier", points = { {1.1, 1.6}, {0.1, 0.85} } })

-- ANIMATIONS

hl.animation({ leaf = "windowsIn", enabled = true, speed = 5, bezier = "slow", style = "popin" })
hl.animation({ leaf = "windowsOut", enabled = true, speed = 5, bezier = "winOut", style = "popin" })
hl.animation({ leaf = "windowsMove", enabled = true, speed = 5, bezier = "wind", style = "slide" })
hl.animation({ leaf = "border", enabled = true, speed = 10, bezier = "linear" })
hl.animation({ leaf = "borderangle", enabled = true, speed = 100, bezier = "linear", style = "once" })
hl.animation({ leaf = "fade", enabled = true, speed = 5, bezier = "overshot" })
hl.animation({ leaf = "workspaces", enabled = true, speed = 5, bezier = "wind" })
hl.animation({ leaf = "windows", enabled = true, speed = 5, bezier = "bounce", style = "popin" })

