-- Standard awesome library
require("awful")
require("awful.autofocus")
require("awful.rules")
-- Theme handling library
require("beautiful")
-- Notification library
require("naughty")
-- Widget Library
require("vicious")


-- {{{ [ Variable definitions ] --
-- Themes define colours, icons, and wallpapers
beautiful.init(awful.util.getdir("config") .. "/ambiance/theme.lua")

-- Commands sent to control the sound Master level
sound_mixer_up = "amixer -q sset Master 3dB+ unmute"
sound_mixer_down = "amixer -q sset Master 3dB- unmute"
sound_mixer_toggle = "amixer -q sset Master toggle"

-- This is used later as the default terminal to run.
terminal = "urxvtc"

-- Default modkey.
-- Usually, Mod4 is the key with a logo between Control and Alt.
-- If you do not like this or do not have such a key,
-- I suggest you to remap Mod4 to another key using xmodmap or other tools.
-- However, you can use another modifier like Mod1, but it may interact with others.
modkey = "Mod4"
-- }}}

-- {{{ [ Tags ] --
-- Define a tag table which hold all screen tags.
tags = {}
for s = 1, screen.count() do
	tags[s] = awful.tag({ 1, 2, 3, 4, 5, 6, 7, 8, 9 }, s, awful.layout.suit.tile)
end
-- }}}

-- {{{[ Menu ] --

the_session_menu_items = {
	{ "quit awesome", awesome.quit },
	{ "reboot", "sudo reboot" },
	{ "shutdown", "sudo halt" }
}

the_session_menu = awful.menu({ items = the_session_menu_items })

the_mouse_rc_menu = awful.menu({
	items = {
		{ "Session", the_session_menu_items },
		{ "Terminal", terminal }}
})


-- Session menu launcher
mylauncher = awful.widget.launcher({
	image = image(beautiful.awesome_icon),
	menu = the_session_menu
})
-- }}}

-- {{{ [ Widgets ] --
-- spacer
spacer = widget({ type = "textbox" })
spacer.text = "  "
smallspacer = widget({ type = "textbox" })
smallspacer.text = " "

-- battery status
battery_status = widget({ type = "imagebox" })
battery_time = widget({ type = "textbox" })
battery_tooltip = awful.tooltip({ objects = {battery_status} })
vicious.register(battery_status, vicious.widgets.bat,
	function (widget,args)
		-- if battery state is full/charged
		if args[1] == "↯" then
			widget.visible = true
			widget.image = image(beautiful.battery_full_icon)

		-- battery is charging
		elseif args[1] == "+" then
			widget.visible = true
			if args[2] >= 80 then
				widget.image = image(beautiful.battery_5_charging_icon)
			elseif args[2] >= 60 then
				widget.image = image(beautiful.battery_4_charging_icon)
			elseif args[2] >= 40 then
				widget.image = image(beautiful.battery_3_charging_icon)
			elseif args[2] >= 20 then
				widget.image = image(beautiful.battery_2_charging_icon)
			elseif args[2] >= 10 then
				widget.image = image(beautiful.battery_1_charging_icon)
			else
				widget.image = image(beautiful.battery_0_charging_icon)
			end

		-- battery is decharging
		elseif args[1] == "-" then
			widget.visible = true
			if args[2] >= 80 then
				widget.image = image(beautiful.battery_5_icon)
			elseif args[2] >= 60 then
				widget.image = image(beautiful.battery_4_icon)
			elseif args[2] >= 40 then
				widget.image = image(beautiful.battery_3_icon)
			elseif args[2] >= 20 then
				widget.image = image(beautiful.battery_2_icon)
			elseif args[2] >= 10 then
				widget.image = image(beautiful.battery_1_icon)
			else
				naughty.notify({ title = "Warning !",
					text = "Battery is very low\nPlease save your work.",
					timeout = 15,
					fg = beautiful.tooltip_fg_color,
					bg = beautiful.tooltip_bg_color})

				widget.image = image(beautiful.battery_0_icon)
			end

		-- no battery
		else
			widget.visible = false
		end

		battery_tooltip:set_text("Battery level : " .. args[2] .. "%")
		battery_time.text = "(" .. args[3] .. ")"

		if args[3] == "N/A" then
			battery_time.visible = false
		else
			battery_time.visible = true
		end

	end,
	1, "BAT0")

-- sound mixer
sound_mixer = widget({ type = "imagebox" })
sound_mixer:buttons(awful.util.table.join(
    awful.button({ }, 1, function() awful.util.spawn(sound_mixer_toggle) end),
    awful.button({ }, 4, function() awful.util.spawn(sound_mixer_up) end),
    awful.button({ }, 5, function() awful.util.spawn(sound_mixer_down) end)
))
sound_mixer_tooltip = awful.tooltip({ objects = {sound_mixer} })
vicious.register(sound_mixer, vicious.widgets.volume, 
	function (widget,args)

		if args[2] == "♩" then
			sound_mixer_tooltip:set_text("Master channel is muted.")
			widget.image = image(beautiful.sound_mute_icon)
		else
			sound_mixer_tooltip:set_text("Master channel level : " .. args[1] .. "%")
			if args[1] >= 66 then
				widget.image = image(beautiful.sound_3_icon)
			elseif args[1] >= 33 then
				widget.image = image(beautiful.sound_2_icon)
			else
				widget.image = image(beautiful.sound_1_icon)
			end
		end
	end,
	1, "Master")

-- clock
clock = awful.widget.textclock({ align = "center" })

-- mpd
mpdwidget = widget({ type = "textbox" })
vicious.register(mpdwidget, vicious.widgets.mpd,
    function (widget, args)
        if args["{state}"] == "Stop" then 
            return " - "
        else 
            return args["{Artist}"]..' - '.. args["{Title}"] .. ' [' .. args["{Album}"] .. ']'
        end
    end, 1)

-- systray
system_tray = widget({ type = "systray" })

-- For each screen, we build our interface
wiboxes = {}
promptboxes = {}
taglists = {}
taglists.buttons = awful.util.table.join(
                    awful.button({ }, 1, awful.tag.viewonly),
                    awful.button({ modkey }, 1, awful.client.movetotag),
                    awful.button({ }, 3, awful.tag.viewtoggle),
                    awful.button({ modkey }, 3, awful.client.toggletag),
                    awful.button({ }, 4, awful.tag.viewnext),
                    awful.button({ }, 5, awful.tag.viewprev)
                    )
tasklists = {}
tasklists.buttons = awful.util.table.join(
                     awful.button({ }, 1, function (c)
                                              if not c:isvisible() then
                                                  awful.tag.viewonly(c:tags()[1])
                                              end
                                              client.focus = c
                                              c:raise()
                                          end),
                     awful.button({ }, 3, function ()
                                              if instance then
                                                  instance:hide()
                                                  instance = nil
                                              else
                                                  instance = awful.menu.clients({ width=350 })
                                              end
                                          end),
                     awful.button({ }, 4, function ()
                                              awful.client.focus.byidx(1)
                                              if client.focus then client.focus:raise() end
                                          end),
                     awful.button({ }, 5, function ()
                                              awful.client.focus.byidx(-1)
                                              if client.focus then client.focus:raise() end
                                          end))

for s = 1, screen.count() do
    -- Create a wibox, a taglist, a promptbox & a tasklist widget for each screen
    wiboxes[s] = awful.wibox({ position = "top", screen = s , bg=beautiful.bg_wibox })
    taglists[s] = awful.widget.taglist(s, awful.widget.taglist.label.all, taglists.buttons)
    promptboxes[s] = awful.widget.prompt({ layout = awful.widget.layout.horizontal.leftright })
    tasklists[s] = awful.widget.tasklist(function(c)
                                              return awful.widget.tasklist.label.currenttags(c, s)
                                          end, tasklists.buttons)

    -- Add widgets to the wibox - order matters
    wiboxes[s].widgets = {
        {
            taglists[s],
            promptboxes[s],
            layout = awful.widget.layout.horizontal.leftright
        },
				mylauncher,
				spacer,
				clock,
				spacer,
				sound_mixer,
				spacer,
				battery_time,
				smallspacer,
				battery_status,
				spacer,
				system_tray,
				spacer,
				mpdwidget,
				spacer,
        tasklists[s],
        layout = awful.widget.layout.horizontal.rightleft
    }
end

-- }}}

-- {{{ [ Root mouse bindings ] --
root.buttons(awful.button({ }, 3, function () the_mouse_rc_menu:toggle() end))
-- }}}

-- {{{ [ Global key bindings ] --
globalkeys = awful.util.table.join(
    awful.key({ modkey,           }, "Left",   awful.tag.viewprev       ),
    awful.key({ modkey,           }, "Right",  awful.tag.viewnext       ),
    awful.key({ modkey,           }, "Escape", awful.tag.history.restore),

    awful.key({ modkey,           }, "j",
        function ()
            awful.client.focus.byidx( 1)
            if client.focus then client.focus:raise() end
        end),
    awful.key({ modkey,           }, "k",
        function ()
            awful.client.focus.byidx(-1)
            if client.focus then client.focus:raise() end
        end),
    awful.key({ modkey,           }, "w", function ()
	naughty.notify({ title = "Tooltip test !",
		text = "Ça marche !!!",
		timeout = 5,
		fg = beautiful.tooltip_fg_color,
		bg = beautiful.tooltip_bg_color
	})
					end),
    -- Layout manipulation
    awful.key({ modkey, "Shift"   }, "j", function () awful.client.swap.byidx(  1)    end),
    awful.key({ modkey, "Shift"   }, "k", function () awful.client.swap.byidx( -1)    end),
    awful.key({ modkey, "Control" }, "j", function () awful.screen.focus_relative( 1) end),
    awful.key({ modkey, "Control" }, "k", function () awful.screen.focus_relative(-1) end),
    awful.key({ modkey,           }, "u", awful.client.urgent.jumpto),
    awful.key({ modkey,           }, "Tab",
        function ()
            awful.client.focus.history.previous()
            if client.focus then
                client.focus:raise()
            end
        end),

    -- Standard program
    awful.key({ modkey,           }, "Return", function () awful.util.spawn(terminal) end),
    awful.key({ modkey, "Control" }, "r", awesome.restart),
    awful.key({ modkey, "Shift"   }, "q", awesome.quit),

    awful.key({ modkey,           }, "t", function () awful.util.spawn("thunar") end),

    awful.key({ modkey,           }, "l",     function () awful.tag.incmwfact( 0.05)    end),
    awful.key({ modkey,           }, "h",     function () awful.tag.incmwfact(-0.05)    end),
    awful.key({ modkey, "Shift"   }, "h",     function () awful.tag.incnmaster( 1)      end),
    awful.key({ modkey, "Shift"   }, "l",     function () awful.tag.incnmaster(-1)      end),
    awful.key({ modkey, "Control" }, "h",     function () awful.tag.incncol( 1)         end),
    awful.key({ modkey, "Control" }, "l",     function () awful.tag.incncol(-1)         end),

    -- Prompt
    awful.key({ modkey },            "r",     function () promptboxes[mouse.screen]:run() end),

    awful.key({ modkey }, "x",
              function ()
                  awful.prompt.run({ prompt = "Run Lua code: " },
                  promptboxes[mouse.screen].widget,
                  awful.util.eval, nil,
                  awful.util.getdir("cache") .. "/history_eval")
              end)
)

-- [ Client keys bindings ] --
clientkeys = awful.util.table.join(
    awful.key({ modkey,           }, "f",      function (c) c.fullscreen = not c.fullscreen  end),
    awful.key({ modkey, "Shift"   }, "c",      function (c) c:kill()                         end),
    awful.key({ modkey, "Control" }, "space",  awful.client.floating.toggle                     ),
    awful.key({ modkey, "Control" }, "Return", function (c) c:swap(awful.client.getmaster()) end),
    awful.key({ modkey,           }, "o",      awful.client.movetoscreen                        ),
    awful.key({ modkey, "Shift"   }, "r",      function (c) c:redraw()                       end),
    awful.key({ modkey,           }, "n",      function (c) c.minimized = not c.minimized    end),
    awful.key({ modkey,           }, "m",
        function (c)
            c.maximized_horizontal = not c.maximized_horizontal
            c.maximized_vertical   = not c.maximized_vertical
        end)
)

-- Compute the maximum number of digit we need, limited to 9
keynumber = 0
for s = 1, screen.count() do
   keynumber = math.min(9, math.max(#tags[s], keynumber));
end

-- Bind all key numbers to tags.
-- Be careful: we use keycodes to make it works on any keyboard layout.
-- This should map on the top row of your keyboard, usually 1 to 9.
for i = 1, keynumber do
    globalkeys = awful.util.table.join(globalkeys,
        awful.key({ modkey }, "#" .. i + 9,
                  function ()
                        local screen = mouse.screen
                        if tags[screen][i] then
                            awful.tag.viewonly(tags[screen][i])
                        end
                  end),
        awful.key({ modkey, "Control" }, "#" .. i + 9,
                  function ()
                      local screen = mouse.screen
                      if tags[screen][i] then
                          awful.tag.viewtoggle(tags[screen][i])
                      end
                  end),
        awful.key({ modkey, "Shift" }, "#" .. i + 9,
                  function ()
                      if client.focus and tags[client.focus.screen][i] then
                          awful.client.movetotag(tags[client.focus.screen][i])
                      end
                  end),
        awful.key({ modkey, "Control", "Shift" }, "#" .. i + 9,
                  function ()
                      if client.focus and tags[client.focus.screen][i] then
                          awful.client.toggletag(tags[client.focus.screen][i])
                      end
                  end))
end

clientbuttons = awful.util.table.join(
    awful.button({ }, 1, function (c) client.focus = c; c:raise() end),
    awful.button({ modkey }, 1, awful.mouse.client.move),
    awful.button({ modkey }, 3, awful.mouse.client.resize))

-- Set keys
root.keys(globalkeys)
-- }}}

-- {{{ Rules
awful.rules.rules = {
    -- All clients will match this rule.
    { rule = { },
      properties = { border_width = beautiful.border_width,
                     border_color = beautiful.border_normal,
                     focus = true,
                     keys = clientkeys,
                     buttons = clientbuttons } },
--	{ rule = { class = "Firefox" }, properties = { tag = tags[1][1] } },
--	{ rule = { class = "Thunderbird" }, properties = { tag = tags[1][2] } },
--	{ rule = { class = "Pcmanfm" }, properties = { tag = tags[1][3] } },
--	{ rule = { class = "Gimp" }, properties = { tag = tags[1][5], floating = true } },
}
-- }}}

-- {{{ Signals
-- Signal function to execute when a new client appears.
client.add_signal("manage", function (c, startup)
    -- Add a titlebar / or create a custom wibox
    -- awful.titlebar.add(c, { modkey = modkey })

    -- Enable sloppy focus
    c:add_signal("mouse::enter", function(c)
        if awful.layout.get(c.screen) ~= awful.layout.suit.magnifier
            and awful.client.focus.filter(c) then
            client.focus = c
        end
    end)

    if not startup then
        -- Set the windows at the slave,
        -- i.e. put it at the end of others instead of setting it master.
        -- awful.client.setslave(c)

        -- Put windows in a smart way, only if they does not set an initial position.
        if not c.size_hints.user_position and not c.size_hints.program_position then
            awful.placement.no_overlap(c)
            awful.placement.no_offscreen(c)
        end
    end
end)

client.add_signal("focus", function(c) c.border_color = beautiful.border_focus end)
client.add_signal("unfocus", function(c) c.border_color = beautiful.border_normal end)
