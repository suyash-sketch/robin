-- Robin's keybindings
-- Inspired by Omarchy 2.1.2
-- Hyprland 0.55+ Lua configuration

local mainMod = "SUPER"

-- =========================================
-- Applications
-- =========================================

hl.bind(mainMod .. " + RETURN",
    hl.dsp.exec_cmd("kitty --start-as=normal"),
    { description = "Terminal" })

hl.bind(mainMod .. " + Q",
    hl.dsp.exec_cmd("ghostty"),
    { description = "Terminal" })

hl.bind(mainMod .. " + E",
    hl.dsp.exec_cmd("dolphin"),
    { description = "File manager" })

--Power Menu
hl.bind("ALT + F4",
    hl.dsp.exec_cmd("$HOME/robin/bin/power-menu"),
    { description = "Power Menu" })

-- Omarchy uses Walker. Keep this if Walker is installed.
hl.bind(mainMod .. " + SPACE",
    hl.dsp.exec_cmd("wofi --show drun"),
    { description = "Application launcher" })

-- Clipboard History
hl.bind(mainMod .. " + V",
    hl.dsp.exec_cmd("$HOME/robin/bin/clipboard-history"),
    { description = "Clipboard history"})

-- =========================================
-- Window management
-- =========================================
--Lock Screen
hl.bind(mainMod .. " + L",
    hl.dsp.exec_cmd("loginctl lock-session"),
    { description = "Lock Screen" })

--Logout
hl.bind("SUPER + SHIFT + M",
    hl.dsp.exit(),
    { description = "Log out of Hyprland" })

hl.bind(mainMod .. " + W",
    hl.dsp.window.close(),
    { description = "Close active window" })

hl.bind("CTRL + ALT + DELETE",
    hl.dsp.exec_cmd("hyprctl clients -j | jq -r '.[].address' | xargs -r -n1 hyprctl dispatch closewindow address:"),
    { description = "Close all windows" })

hl.bind(mainMod .. " + J",
    hl.dsp.layout("togglesplit"),
    { description = "Toggle split direction" })

hl.bind(mainMod .. " + P",
    hl.dsp.window.pseudo(),
    { description = "Toggle pseudotiling" })

hl.bind(mainMod .. " + F",
    hl.dsp.window.float({ action = "toggle" }),
    { description = "Toggle floating" })

hl.bind("F11",
    hl.dsp.window.fullscreen({ action = "toggle" }),
    { description = "Toggle fullscreen" })

-- =========================================
-- Focus and window swapping
-- =========================================

local directions = {
    { key = "left",  dir = "l" },
    { key = "right", dir = "r" },
    { key = "up",    dir = "u" },
    { key = "down",  dir = "d" },
}

for _, item in ipairs(directions) do
    hl.bind(mainMod .. " + " .. item.key,
        hl.dsp.focus({ direction = item.dir }),
        { description = "Focus " .. item.key })

    hl.bind(mainMod .. " + SHIFT + " .. item.key,
        hl.dsp.window.swap({ direction = item.dir }),
        { description = "Swap window " .. item.key })
end

-- Cycle between windows
hl.bind("ALT + Tab",
    hl.dsp.window.cycle_next({ next = true }),
    { description = "Next window" })

hl.bind("ALT + SHIFT + Tab",
    hl.dsp.window.cycle_next({ next = false }),
    { description = "Previous window" })

-- =========================================
-- Workspaces
-- Keep the loop: keycodes 10-19 map to 1-0
-- =========================================

for i = 1, 10 do
    local key = "code:" .. tostring(i + 9)

    hl.bind(mainMod .. " + " .. key,
        hl.dsp.focus({ workspace = i }),
        { description = "Workspace " .. i })

    hl.bind(mainMod .. " + SHIFT + " .. key,
        hl.dsp.window.move({ workspace = i }),
        { description = "Move window to workspace " .. i })
end

-- Cycle through existing workspaces
hl.bind(mainMod .. " + Tab",
    hl.dsp.focus({ workspace = "e+1" }),
    { description = "Next workspace" })

hl.bind(mainMod .. " + SHIFT + Tab",
    hl.dsp.focus({ workspace = "e-1" }),
    { description = "Previous workspace" })

-- Scroll through workspaces with SUPER + mouse wheel
hl.bind(mainMod .. " + mouse_down",
    hl.dsp.focus({ workspace = "e+1" }),
    { description = "Next workspace by scrolling" })

hl.bind(mainMod .. " + mouse_up",
    hl.dsp.focus({ workspace = "e-1" }),
    { description = "Previous workspace by scrolling" })

-- =========================================
-- Resize windows
-- =========================================

hl.bind(mainMod .. " + code:20",
    hl.dsp.window.resize({ x = -100, y = 0, relative = true }),
    { description = "Resize window horizontally -" })

hl.bind(mainMod .. " + code:21",
    hl.dsp.window.resize({ x = 100, y = 0, relative = true }),
    { description = "Resize window horizontally +" })

hl.bind(mainMod .. " + SHIFT + code:20",
    hl.dsp.window.resize({ x = 0, y = -100, relative = true }),
    { description = "Resize window vertically -" })

hl.bind(mainMod .. " + SHIFT + code:21",
    hl.dsp.window.resize({ x = 0, y = 100, relative = true }),
    { description = "Resize window vertically +" })

-- Move/resize windows with SUPER + mouse
hl.bind(mainMod .. " + mouse:272",
    hl.dsp.window.drag(),
    { mouse = true, description = "Move window with mouse" })

hl.bind(mainMod .. " + mouse:273",
    hl.dsp.window.resize(),
    { mouse = true, description = "Resize window with mouse" })

-- =========================================
-- Volume and media keys
-- Uses PipeWire directly; no SwayOSD dependency
-- =========================================

hl.bind("XF86AudioRaiseVolume",
    hl.dsp.exec_cmd("uwsm app -- swayosd-client --output-volume +5"),
    { repeating = true, locked = true, description = "Volume up" })

hl.bind("XF86AudioLowerVolume",
    hl.dsp.exec_cmd("uwsm app -- swayosd-client --output-volume -5"),
    { repeating = true, locked = true, description = "Volume down" })

hl.bind("XF86AudioMute",
    hl.dsp.exec_cmd("uwsm app -- swayosd-client --output-volume mute-toggle"),
    { locked = true, description = "Mute audio" })

hl.bind("XF86AudioMicMute",
    hl.dsp.exec_cmd("uwsm app -- swayosd-client --input-volume mute-toggle"),
    { locked = true, description = "Mute microphone" })

-- Requires playerctl
hl.bind("XF86AudioNext",
    hl.dsp.exec_cmd("playerctl next"),
    { locked = true, description = "Next track" })

hl.bind("XF86AudioPrev",
    hl.dsp.exec_cmd("playerctl previous"),
    { locked = true, description = "Previous track" })

hl.bind("XF86AudioPlay",
    hl.dsp.exec_cmd("playerctl play-pause"),
    { locked = true, description = "Play/pause" })

hl.bind("XF86AudioPause",
    hl.dsp.exec_cmd("playerctl play-pause"),
    { locked = true, description = "Play/pause" })

-- Laptop brightness; requires brightnessctl
hl.bind("XF86MonBrightnessUp",
    hl.dsp.exec_cmd("uwsm app -- swayosd-client --brightness +5"),
    { repeating = true, locked = true, description = "Brightness up" })

hl.bind("XF86MonBrightnessDown",
    hl.dsp.exec_cmd("uwsm app -- swayosd-client --brightness -5"),
    { repeating = true, locked = true, description = "Brightness down" })

-- =========================================
-- Screenshots
-- =========================================

hl.bind("PRINT",
    hl.dsp.exec_cmd("$HOME/robin/bin/screenshot region"),
    { description = "Screenshot region" })

hl.bind("SHIFT + PRINT",
    hl.dsp.exec_cmd("$HOME/robin/bin/screenshot window"),
    { description = "Screenshot window" })

hl.bind("CTRL + PRINT",
    hl.dsp.exec_cmd("$HOME/robin/bin/screenshot output"),
    { description = "Screenshot display" })
