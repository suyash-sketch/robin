
-- Robin's autostart
-- Inspired by Omarchy 2.1.2

-- Set to true if you log in using the
-- "Hyprland (uwsm-managed)" session.
local use_uwsm = true

local function start_app(command)
    if use_uwsm then
        hl.exec_cmd("uwsm app -- " .. command)
    else
        hl.exec_cmd(command)
    end
end

hl.on("hyprland.start", function()

    -- Complete the PAM-to-KWallet handoff.
    hl.exec_cmd("systemctl --user start plasma-kwallet-pam.service")

    -- Idle management and screen locking
    -- Hypridle is managed by its systemd user service.

    -- Status bar
    start_app("waybar")

    -- Notifications
    -- Mako is managed by its systemd user service.

    -- Volume and brightness OSD
    start_app("swayosd-server")

    -- Input method, if you use Fcitx5
    -- start_app("fcitx5 -d")

    -- Persistent clipboard, if installed
    -- start_app(
    --     "wl-clip-persist --clipboard regular " ..
    --     "--all-mime-type-regex " ..
    --     "'^(?!x-kde-passwordManagerHint).+'"
    -- )
    start_app("wl-paste --type text --watch cliphist store")
    start_app("wl-paste --type image --watch cliphist store")

    -- Wallpaper will be configured separately.
    -- Do not use Omarchy's current/background symlink.

    -- Start one appropriate Polkit authentication
    -- agent after checking which one Fedora provides.
    start_app("/usr/libexec/kf6/polkit-kde-authentication-agent-1")
end)
