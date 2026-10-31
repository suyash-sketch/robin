-- Hide KDE's Xwayland Video Bridge window.
-- It exists for screen sharing, not as a visible app.

hl.window_rule({
    name = "xwayland-video-bridge-fix",
    match = {
        class = "xwaylandvideobridge",
    },

    no_initial_focus = true,
    no_focus = true,
    no_anim = true,
    no_blur = true,
    max_size = { 1, 1 },
    opacity = 0.0,
})

hl.window_rule({
    match = { class = "satty" },
    no_anim = true,
    float = true,
    center = true,
    size = { 1100, 760 },
})
