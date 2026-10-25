-- Hyprland 0.56.2 Lua configuration
-- Reconstructed from the user's previous hyprland.lua.
-- Keep hyprland.conf until this file has been tested successfully at login.

------------------
-- MONITORS
------------------
hl.monitor({
    output = "",
    mode = "1920x1080@60",
    position = "auto",
    scale = 1.20,
})

------------------
-- PROGRAMS
------------------
local terminal = "kitty"
local fileManager = "dolphin"
local menu = "hyprlauncher"
local mainMod = "SUPER"

------------------
-- AUTOSTART
------------------
hl.on("hyprland.start", function()
    hl.exec_cmd("waybar")
    hl.exec_cmd("swaync")
    -- Start the wallpaper daemon, then set the wallpaper.
    hl.exec_cmd("awww-daemon & sleep 1; awww img /home/el-sin-nombre/Downloads/PICs/wallhaven-1qovp1.png --transition-type fade --transition-duration 1.0 --transition-fps 60")
end)

------------------
-- ENVIRONMENT
------------------
hl.env("XCURSOR_SIZE", "24")
hl.env("HYPRCURSOR_SIZE", "24")

------------------
-- GENERAL / LOOK AND FEEL
------------------
hl.config({
    general = {
        gaps_in = 5,
        gaps_out = 10,
        border_size = 0,
        col = {
            active_border = {
                colors = { "rgba(33ccffee)", "rgba(00ff99ee)" },
                angle = 45,
            },
            inactive_border = "rgba(595959aa)",
        },
        resize_on_border = false,
        allow_tearing = false,
        layout = "dwindle",
    },

    decoration = {
        rounding = 6,
        rounding_power = 2,
        active_opacity = 1.0,
        inactive_opacity = 1.0,
        shadow = {
            enabled = true,
            range = 4,
            render_power = 3,
            color = 0xee1a1a1a,
        },
        blur = {
            enabled = true,
            size = 10,
            passes = 3,
	    ignore_opacity = true,
	    new_optimizations = true,
            vibrancy = 0.2,
        },
    },

    animations = {
        enabled = true,
    },

    dwindle = {
        preserve_split = true,
    },

    master = {
        new_status = "master",
    },

    misc = {
        force_default_wallpaper = -1,
        disable_hyprland_logo = false,
    },

    input = {
        kb_layout = "us",
        kb_variant = "",
        kb_model = "",
        kb_options = "",
        kb_rules = "",
        follow_mouse = 1,
        sensitivity = 0,
        touchpad = {
            natural_scroll = false,
        },
    },
})

------------------
-- ANIMATIONS
------------------
hl.curve("easeOutQuint", {
    type = "bezier",
    points = { { 0.23, 1 }, { 0.32, 1 } },
})
hl.curve("easeInOutCubic", {
    type = "bezier",
    points = { { 0.65, 0.05 }, { 0.36, 1 } },
})
hl.curve("linear", {
    type = "bezier",
    points = { { 0, 0 }, { 1, 1 } },
})
hl.curve("almostLinear", {
    type = "bezier",
    points = { { 0.5, 0.5 }, { 0.75, 1 } },
})
hl.curve("quick", {
    type = "bezier",
    points = { { 0.15, 0 }, { 0.1, 1 } },
})

hl.animation({ leaf = "global", enabled = true, speed = 10, bezier = "default" })
hl.animation({ leaf = "border", enabled = true, speed = 5.39, bezier = "easeOutQuint" })
hl.animation({ leaf = "windows", enabled = true, speed = 4.79, bezier = "easeOutQuint" })
hl.animation({ leaf = "windowsIn", enabled = true, speed = 4.1, bezier = "easeOutQuint", style = "popin 87%" })
hl.animation({ leaf = "windowsOut", enabled = true, speed = 1.49, bezier = "linear", style = "popin 87%" })
hl.animation({ leaf = "fadeIn", enabled = true, speed = 1.73, bezier = "almostLinear" })
hl.animation({ leaf = "fadeOut", enabled = true, speed = 1.46, bezier = "almostLinear" })
hl.animation({ leaf = "fade", enabled = true, speed = 3.03, bezier = "quick" })
hl.animation({ leaf = "layers", enabled = true, speed = 3.81, bezier = "easeOutQuint" })
hl.animation({ leaf = "layersIn", enabled = true, speed = 4, bezier = "easeOutQuint", style = "fade" })
hl.animation({ leaf = "layersOut", enabled = true, speed = 1.5, bezier = "linear", style = "fade" })
hl.animation({ leaf = "fadeLayersIn", enabled = true, speed = 1.79, bezier = "almostLinear" })
hl.animation({ leaf = "fadeLayersOut", enabled = true, speed = 1.39, bezier = "almostLinear" })
hl.animation({ leaf = "workspaces", enabled = true, speed = 4.5, bezier = "easeOutQuint" })
hl.animation({ leaf = "workspacesIn", enabled = true, speed = 4.5, bezier = "easeOutQuint" })
hl.animation({ leaf = "workspacesOut", enabled = true, speed = 4.5, bezier = "easeOutQuint" })

------------------
-- GESTURES / DEVICES
------------------
hl.gesture({
    fingers = 3,
    direction = "horizontal",
    action = "workspace",
})

hl.device({
    name = "epic-mouse-v1",
    sensitivity = -0.5,
})

------------------
-- WINDOW RULES
------------------
hl.window_rule({
    name = "kitty-floating-terminal",
    match = { class = "kitty-float" },
    float = true,
    size = "700 600",
    center = true,
})

hl.window_rule({
    name = "suppress-maximize-events",
    match = { class = ".*" },
    suppress_event = "maximize",
})

hl.window_rule({
    name = "fix-xwayland-drags",
    match = {
        class = "^$",
        title = "^$",
        xwayland = true,
        float = true,
        fullscreen = false,
        pin = false,
    },
    no_focus = true,
})

hl.window_rule({
    name = "move-hyprland-run",
    match = { class = "hyprland-run" },
    move = "20 monitor_h-120",
    float = true,
})

------------------
-- SCREENSHOTS
------------------
-- Print: select an area and annotate in Swappy.
hl.bind("Print", hl.dsp.exec_cmd([[grim -g "$(slurp)" - | swappy -f -]]))

-- SUPER + Print: select an area and copy it to the Wayland clipboard.
hl.bind("SUPER + Print", hl.dsp.exec_cmd([[grim -g "$(slurp -d)" - | wl-copy]]))

-- SHIFT + Print: save the full screen to ~/Pictures/Screenshots.
hl.bind("SHIFT + Print", hl.dsp.exec_cmd([[mkdir -p "$HOME/Pictures/Screenshots" && grim "$HOME/Pictures/Screenshots/screenshot-$(date +%Y-%m-%d_%H-%M-%S).png"]]))

------------------
-- APPLICATIONS / WINDOW ACTIONS
------------------
hl.bind(mainMod .. " + Q", hl.dsp.exec_cmd(terminal))
hl.bind(mainMod .. " + Z", hl.dsp.window.close())
hl.bind(mainMod .. " + E", hl.dsp.exec_cmd(fileManager))
hl.bind(mainMod .. " + T", hl.dsp.exec_cmd("alacritty"))
hl.bind(mainMod .. " + D", hl.dsp.exec_cmd("rofi -show drun -theme ~/.config/rofi/liquid-glass.rasi"))
hl.bind(mainMod .. " + M", hl.dsp.exec_cmd("hyprshutdown || hyprctl dispatch exit"))
hl.bind(mainMod .. " + N", hl.dsp.exec_cmd("pgrep -x discord >/dev/null && killall discord || discord"))
hl.bind(mainMod .. " + V", hl.dsp.window.float({ action = "toggle" }))
hl.bind(mainMod .. " + R", hl.dsp.exec_cmd(menu))
hl.bind(mainMod .. " + P", hl.dsp.window.pseudo())
hl.bind(mainMod .. " + J", hl.dsp.layout("togglesplit"))
hl.bind(mainMod .. " + K", hl.dsp.exec_cmd("kitty --class kitty-float"))

------------------
-- MOUSE: SUPER + LEFT DRAG TO MOVE, RIGHT DRAG TO RESIZE
------------------
hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })
-- SUPER + ALT + trackpad drag = resize
hl.bind(mainMod .. " + ALT_L", hl.dsp.window.resize(), { mouse = true })

------------------
-- LID SWITCH
------------------
hl.bind("switch:Lid Switch", hl.dsp.exec_cmd("hyprlock"), { locked = true })

------------------
-- FOCUS DIRECTION
------------------
hl.bind(mainMod .. " + left", hl.dsp.focus({ direction = "left" }))
hl.bind(mainMod .. " + right", hl.dsp.focus({ direction = "right" }))
hl.bind(mainMod .. " + up", hl.dsp.focus({ direction = "up" }))
hl.bind(mainMod .. " + down", hl.dsp.focus({ direction = "down" }))

------------------
-- WORKSPACES 1-10
------------------
for i = 1, 9 do
    hl.bind(mainMod .. " + " .. i, hl.dsp.focus({ workspace = tostring(i) }))
    hl.bind(mainMod .. " + SHIFT + " .. i, hl.dsp.window.move({ workspace = tostring(i) }))
end
hl.bind(mainMod .. " + 0", hl.dsp.focus({ workspace = "10" }))
hl.bind(mainMod .. " + SHIFT + 0", hl.dsp.window.move({ workspace = "10" }))

------------------
-- SPECIAL WORKSPACE
------------------
hl.bind(mainMod .. " + S", hl.dsp.workspace.toggle_special("magic"))
hl.bind(mainMod .. " + SHIFT + S", hl.dsp.window.move({ workspace = "special:magic" }))

------------------
-- SCROLL WORKSPACES
------------------
hl.bind(mainMod .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" }), { mouse = true })
hl.bind(mainMod .. " + mouse_up", hl.dsp.focus({ workspace = "e-1" }), { mouse = true })

------------------
-- MULTIMEDIA KEYS
------------------
hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"), { locked = true, repeating = true })
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"), { locked = true, repeating = true })
hl.bind("XF86AudioMute", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"), { locked = true, repeating = true })
hl.bind("XF86AudioMicMute", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"), { locked = true, repeating = true })
hl.bind("XF86MonBrightnessUp", hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%+"), { locked = true, repeating = true })
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%-"), { locked = true, repeating = true })
hl.bind("XF86AudioNext", hl.dsp.exec_cmd("playerctl next"), { locked = true })
hl.bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPlay", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPrev", hl.dsp.exec_cmd("playerctl previous"), { locked = true })

-- Liquid glass blur for Waybar
hl.layer_rule({
    name = "waybar-blur",
    match = { namespace = "^waybar$" },
    blur = true,
    ignore_alpha = 0.05,
})

hl.layer_rule({
    name = "rofi-liquid-glass",
    match = {
        namespace = "rofi",
    },
    blur = true,
    ignore_alpha = 0.05,
})
