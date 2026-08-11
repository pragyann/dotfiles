local wezterm = require("wezterm")
local mux = wezterm.mux

local config = wezterm.config_builder()

-- fraction of the active screen the startup window should occupy
local WIDTH_RATIO = 0.86
local HEIGHT_RATIO = 0.85

-- -- Dim unfocused windows so the focused one is obvious at a glance.
-- local UNFOCUSED_FOREGROUND_TEXT_HSB = { hue = 1.0, saturation = 0.25, brightness = 0.45 }
-- local UNFOCUSED_WINDOW_BACKGROUND_OPACITY = 0.62
--
-- -- get_config_overrides() hands back a copy, so the current value is never the
-- -- same table we last stored; compare the fields instead of the identity.
-- local function same_text_hsb(actual, expected)
--     if actual == nil or expected == nil then
--         return actual == expected
--     end
--     return actual.hue == expected.hue
--         and actual.saturation == expected.saturation
--         and actual.brightness == expected.brightness
-- end
--
-- wezterm.on("window-focus-changed", function(window)
--     local overrides = window:get_config_overrides() or {}
--     local text_hsb, opacity
--     if not window:is_focused() then
--         text_hsb = UNFOCUSED_FOREGROUND_TEXT_HSB
--         opacity = UNFOCUSED_WINDOW_BACKGROUND_OPACITY
--     end
--
--     -- Only write when one of the two values we own actually changes; a redundant
--     -- set_config_overrides() call would trigger another config reload.
--     if same_text_hsb(overrides.foreground_text_hsb, text_hsb) and overrides.window_background_opacity == opacity then
--         return
--     end
--
--     overrides.foreground_text_hsb = text_hsb
--     overrides.window_background_opacity = opacity
--     window:set_config_overrides(overrides)
-- end)

-- Window ids we have already sized, so a config reload (including the one our
-- own focus handler triggers) does not yank a resized window back to default.
local sized_windows = {}

local function size_and_center(gui)
    if gui == nil or sized_windows[gui:window_id()] then
        return
    end
    sized_windows[gui:window_id()] = true

    local screen = wezterm.gui.screens().active
    local width = math.floor(screen.width * WIDTH_RATIO)
    local height = math.floor(screen.height * HEIGHT_RATIO)

    gui:set_inner_size(width, height)
    gui:set_position(
        screen.x + math.floor((screen.width - width) / 2),
        screen.y + math.floor((screen.height - height) / 2)
    )
end

wezterm.on("gui-startup", function(cmd)
    local _, _, window = mux.spawn_window(cmd or {})
    size_and_center(window:gui_window())
end)

-- gui-startup only fires for the session's first window; this fires for every
-- window, so CMD+n (SpawnWindow) gets the same geometry.
wezterm.on("window-config-reloaded", function(window)
    size_and_center(window)
end)

config.color_scheme = "rose-pine-moon"
config.font = wezterm.font("Hack Nerd Font")
config.font_size = 15.0
config.window_background_opacity = 0.8
config.macos_window_background_blur = 50
config.hide_tab_bar_if_only_one_tab = true
config.window_decorations = "RESIZE"

-- ---------------------------------------------------------------- tab bar --
-- rose-pine-moon palette, so the bar is tinted from the same source as the
-- terminal colors rather than wezterm's default grey.
local BASE = "#232136" -- bar background
local SURFACE = "#2a273f" -- hover
local OVERLAY = "#393552" -- active tab
local MUTED = "#6e6a86" -- inactive text
local SUBTLE = "#908caa" -- hover text
local TEXT = "#e0def4" -- active text

config.use_fancy_tab_bar = true
config.tab_max_width = 32

-- window_frame styles the chrome the fancy tab bar is drawn into; the tab bar
-- has its own font, independent of config.font_size.
config.window_frame = {
    font = wezterm.font({ family = "Hack Nerd Font", weight = "Bold" }),
    font_size = 12.0,
    active_titlebar_bg = BASE,
    inactive_titlebar_bg = BASE,
}

-- Tabs can't be dragged to reorder them: dragging anywhere in the tab bar is
-- claimed by the window-drag chrome, so move the active tab with the keyboard.
config.keys = {
    { key = "LeftArrow", mods = "SHIFT|SUPER", action = wezterm.action.MoveTabRelative(-1) },
    { key = "RightArrow", mods = "SHIFT|SUPER", action = wezterm.action.MoveTabRelative(1) },
}

config.colors = {
    tab_bar = {
        active_tab = { bg_color = OVERLAY, fg_color = TEXT },
        inactive_tab = { bg_color = BASE, fg_color = MUTED },
        inactive_tab_hover = { bg_color = SURFACE, fg_color = SUBTLE, italic = false },
        new_tab = { bg_color = BASE, fg_color = MUTED },
        new_tab_hover = { bg_color = OVERLAY, fg_color = TEXT },
    },
}

return config
