---------------------------
-- Ambiance awesome theme --
---------------------------

theme = {}

theme_dir = awful.util.getdir("config") .. "/ambiance"

theme.font          = "Ubuntu 10"

-- You can use your own command to set your wallpaper
-- theme.wallpaper_cmd = { "awsetbg " .. theme_dir .. "/background.jpg" }
theme.wallpaper_cmd = { "nitrogen --restore "}

theme.bg_normal     = "#3c3b37"
theme.bg_focus      = "#54524d"
theme.bg_urgent     = "#ff0000" --
theme.bg_minimize   = "#444444" --

theme.fg_normal     = "#ffffff"
theme.fg_focus      = "#fcfbfb"
theme.fg_urgent     = "#ffffff" --
theme.fg_minimize   = "#ffffff" --

theme.border_width  = "2"
theme.border_normal = "#3c3b37"
theme.border_focus  = "#54524d"
theme.border_marked = "#91231c" --

-- There are other variable sets
-- overriding the default one when
-- defined, the sets are:
-- [taglist|tasklist]_[bg|fg]_[focus|urgent]
-- titlebar_[bg|fg]_[normal|focus]
-- tooltip_[font|opacity|fg_color|bg_color|border_width|border_color]
-- mouse_finder_[color|timeout|animate_timeout|radius|factor]
-- Example:
--theme.taglist_bg_focus = "#ff0000"

theme.tooltip_fg_color = "#fff"
theme.tooltip_bg_color = "#300a24"

-- Display the taglist squares
theme.taglist_squares_sel   = "/usr/share/awesome/themes/default/taglist/squarefw.png"
theme.taglist_squares_unsel = "/usr/share/awesome/themes/default/taglist/squarew.png"

theme.tasklist_floating_icon = "/usr/share/awesome/themes/default/tasklist/floatingw.png"

-- Variables set for theming the menu:
-- menu_[bg|fg]_[normal|focus]
-- menu_[border_color|border_width]
theme.menu_submenu_icon = theme_dir .. "/submenu.png"
theme.menu_border_width = "0"
theme.menu_height = "26"
theme.menu_width  = "140"
theme.menu_bg_focus = "#a99a84"

-- You can add as many variables as
-- you wish and access them by using
-- beautiful.variable in your rc.lua

-- Define the image to load
theme.titlebar_close_button_normal = "/usr/share/awesome/themes/default/titlebar/close_normal.png"
theme.titlebar_close_button_focus  = "/usr/share/awesome/themes/default/titlebar/close_focus.png"

theme.titlebar_ontop_button_normal_inactive = "/usr/share/awesome/themes/default/titlebar/ontop_normal_inactive.png"
theme.titlebar_ontop_button_focus_inactive  = "/usr/share/awesome/themes/default/titlebar/ontop_focus_inactive.png"
theme.titlebar_ontop_button_normal_active = "/usr/share/awesome/themes/default/titlebar/ontop_normal_active.png"
theme.titlebar_ontop_button_focus_active  = "/usr/share/awesome/themes/default/titlebar/ontop_focus_active.png"

theme.titlebar_sticky_button_normal_inactive = "/usr/share/awesome/themes/default/titlebar/sticky_normal_inactive.png"
theme.titlebar_sticky_button_focus_inactive  = "/usr/share/awesome/themes/default/titlebar/sticky_focus_inactive.png"
theme.titlebar_sticky_button_normal_active = "/usr/share/awesome/themes/default/titlebar/sticky_normal_active.png"
theme.titlebar_sticky_button_focus_active  = "/usr/share/awesome/themes/default/titlebar/sticky_focus_active.png"

theme.titlebar_floating_button_normal_inactive = "/usr/share/awesome/themes/default/titlebar/floating_normal_inactive.png"
theme.titlebar_floating_button_focus_inactive  = "/usr/share/awesome/themes/default/titlebar/floating_focus_inactive.png"
theme.titlebar_floating_button_normal_active = "/usr/share/awesome/themes/default/titlebar/floating_normal_active.png"
theme.titlebar_floating_button_focus_active  = "/usr/share/awesome/themes/default/titlebar/floating_focus_active.png"

theme.titlebar_maximized_button_normal_inactive = "/usr/share/awesome/themes/default/titlebar/maximized_normal_inactive.png"
theme.titlebar_maximized_button_focus_inactive  = "/usr/share/awesome/themes/default/titlebar/maximized_focus_inactive.png"
theme.titlebar_maximized_button_normal_active = "/usr/share/awesome/themes/default/titlebar/maximized_normal_active.png"
theme.titlebar_maximized_button_focus_active  = "/usr/share/awesome/themes/default/titlebar/maximized_focus_active.png"

-- You can use your own layout icons like this:
theme.layout_fairh = "/usr/share/awesome/themes/default/layouts/fairh.png"
theme.layout_fairv = "/usr/share/awesome/themes/default/layouts/fairv.png"
theme.layout_floating  = "/usr/share/awesome/themes/default/layouts/floating.png"
theme.layout_magnifier = "/usr/share/awesome/themes/default/layouts/magnifier.png"
theme.layout_max = "/usr/share/awesome/themes/default/layouts/max.png"
theme.layout_fullscreen = "/usr/share/awesome/themes/default/layouts/fullscreen.png"
theme.layout_tilebottom = "/usr/share/awesome/themes/default/layouts/tilebottom.png"
theme.layout_tileleft   = "/usr/share/awesome/themes/default/layouts/tileleft.png"
theme.layout_tile = "/usr/share/awesome/themes/default/layouts/tile.png"
theme.layout_tiletop = "/usr/share/awesome/themes/default/layouts/tiletop.png"
theme.layout_spiral  = "/usr/share/awesome/themes/default/layouts/spiral.png"
theme.layout_dwindle = "/usr/share/awesome/themes/default/layouts/dwindle.png"


theme.awesome_icon = theme_dir .. "/awesome-icon.png"

-- Sound level status icons
theme.sound_mute_icon = theme_dir .. "/status/sound_mute.png"
theme.sound_1_icon = theme_dir .. "/status/sound_1.png"
theme.sound_2_icon = theme_dir .. "/status/sound_2.png"
theme.sound_3_icon = theme_dir .. "/status/sound_3.png"

-- Battery level status icons
theme.battery_full_icon = theme_dir .. "/status/battery_full.png"

theme.battery_0_icon = theme_dir .. "/status/battery_0.png"
theme.battery_1_icon = theme_dir .. "/status/battery_1.png"
theme.battery_2_icon = theme_dir .. "/status/battery_2.png"
theme.battery_3_icon = theme_dir .. "/status/battery_3.png"
theme.battery_4_icon = theme_dir .. "/status/battery_4.png"
theme.battery_5_icon = theme_dir .. "/status/battery_5.png"

theme.battery_0_charging_icon = theme_dir .. "/status/battery_0_charging.png"
theme.battery_1_charging_icon = theme_dir .. "/status/battery_1_charging.png"
theme.battery_2_charging_icon = theme_dir .. "/status/battery_2_charging.png"
theme.battery_3_charging_icon = theme_dir .. "/status/battery_3_charging.png"
theme.battery_4_charging_icon = theme_dir .. "/status/battery_4_charging.png"
theme.battery_5_charging_icon = theme_dir .. "/status/battery_5_charging.png"

return theme
-- vim: filetype=lua:expandtab:shiftwidth=4:tabstop=8:softtabstop=4:encoding=utf-8:textwidth=80
