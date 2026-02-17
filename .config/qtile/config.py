import os

import libqtile.resources
from libqtile import bar, layout, qtile, widget
from libqtile.config import Click, Drag, Group, Key, Match, Screen
from libqtile.lazy import lazy
from libqtile.utils import guess_terminal

win = "mod4"
mod=win
alt = "mod1"
ctrl = 'control'
shift = 'shift'
tilde = '/home/n'
terminal = guess_terminal()

#  _____                 _   _                 
# |  ___|   _ _ __   ___| |_(_) ___  _ __  ___ 
# | |_ | | | | '_ \ / __| __| |/ _ \| '_ \/ __|
# |  _|| |_| | | | | (__| |_| | (_) | | | \__ \
# |_|   \__,_|_| |_|\___|\__|_|\___/|_| |_|___/

@lazy.function
def float_to_front(qtile):
	"""
	Bring all floating windows of the group to front
	https://github.com/qtile/qtile/issues/974 todo
	"""
	
	focused_window = qtile.current_window

# 	logger.warning(str(dir(qtile)))
	for window in qtile.current_group.windows:
		if window.floating:
			window.cmd_bring_to_front()
			window.cmd_focus()


	if focused_window and focused_window.floating:
		focused_window.cmd_bring_to_front()
keys = [
	# A list of available commands that can be bound to keys can be found
	# at https://docs.qtile.org/en/latest/manual/config/lazy.html
	# Switch between windows
	Key([win], "h", lazy.layout.left(), desc="Move focus to left"),
	Key([win], "l", lazy.layout.right(), desc="Move focus to right"),
	Key([win], "j", lazy.layout.down(), desc="Move focus down"),
	Key([win], "k", lazy.layout.up(), desc="Move focus up"),

	Key([alt], "Tab", lazy.layout.next(), desc="Move window focus to other window"),
	Key([alt, "shift"], "Tab", lazy.next_screen(), desc="Switch focus to other screen"),

	# Move windows between left/right columns or move up/down in current stack.
	# Moving out of range in Columns layout will create new column.
	Key([win, "shift"], "h", lazy.layout.shuffle_left(), desc="Move window to the left"),
	Key([win, "shift"], "l", lazy.layout.shuffle_right(), desc="Move window to the right"),
	Key([win, "shift"], "j", lazy.layout.shuffle_down(), desc="Move window down"),
	Key([win, "shift"], "k", lazy.layout.shuffle_up(), desc="Move window up"),

	# Grow windows. If current window is on the edge of screen and direction
	# will be to screen edge - window would shrink.
	Key([win, "control"], "h", lazy.layout.grow_left(), desc="Grow window to the left"),
	Key([win, "control"], "l", lazy.layout.grow_right(), desc="Grow window to the right"),
	Key([win, "control"], "j", lazy.layout.grow_down(), desc="Grow window down"),
	Key([win, "control"], "k", lazy.layout.grow_up(), desc="Grow window up"),
	Key([win], "n", lazy.layout.normalize(), desc="Reset all window sizes"),

	# Toggle between split and unsplit sides of stack.
	# Split = all windows displayed
	# Unsplit = 1 window displayed, like Max layout, but still with
	# multiple stack panes
	Key([win, "shift"], "Tab", lazy.layout.toggle_split(), desc="Toggle between split and unsplit sides of stack"),
	Key([mod], "Return", lazy.spawn(terminal), desc="Launch terminal"),
	# Toggle between different layouts as defined below
	Key([win], "Tab", lazy.next_layout(), desc="Toggle between layouts"),

	Key([win], "c", lazy.window.kill(), desc="Kill focused window"),
	Key([win], "f", lazy.window.toggle_fullscreen(), desc="Toggle fullscreen"),
	Key([win, shift], "f", lazy.window.toggle_floating(), desc="Float focused window"),

	Key([win, "control"], "r", lazy.restart(), desc="Restart Qtile"),
	Key([win, "control"], "q", lazy.shutdown(), desc="Shutdown Qtile"),
	Key(
		[mod],
		"f",
		lazy.window.toggle_fullscreen(),
		desc="Toggle fullscreen on the focused window",
	),
	Key([mod], "t", lazy.window.toggle_floating(), desc="Toggle floating on the focused window"),
	Key([mod], "r", lazy.spawncmd(), desc="Spawn a command using a prompt widget"),

	# Sound and Brightness
	Key([], "XF86AudioMute", lazy.spawn("pactl set-sink-mute @DEFAULT_SINK@ toggle")),
	Key([], "XF86AudioLowerVolume", lazy.spawn("pactl set-sink-volume @DEFAULT_SINK@ -10%")),
	Key([], "XF86AudioRaiseVolume", lazy.spawn("pactl set-sink-volume @DEFAULT_SINK@ +10%")),
	Key([], "XF86MonBrightnessUp", lazy.spawn("brightnessctl set +20")),
	Key([], "XF86MonBrightnessDown", lazy.spawn("brightnessctl set 20-")),
	Key([], "XF86AudioPlay", lazy.spawn('cmus-remote -u')),
	Key(['mod2'], "XF86AudioPause", lazy.spawn('cmus-remote -u')),
	Key([], "XF86AudioNext", lazy.spawn('cmus-remote --next')),
	Key([], "XF86AudioPrev", lazy.spawn('cmus-remote --prev')),
	Key([], "Print", lazy.spawn("flameshot full --clipboard")),
	Key([ctrl], "Print", lazy.spawn("flameshot full")),
	Key([shift], "Print", lazy.spawn("flameshot gui")),

	# Screen Lock
	# Note: win-l is already is use
	Key([win], "o", lazy.spawn("slock")),

	Key([alt, "control"], 'tab', float_to_front, desc="Floating windows to front"),
	Key([win, "control"], 'tab', float_to_front, desc="Floating windows to front"),
]

# Add key bindings to switch VTs in Wayland.
# We can't check qtile.core.name in default config as it is loaded before qtile is started
# We therefore defer the check until the key binding is run by using .when(func=...)
for vt in range(1, 8):
	keys.append(
		Key(
			["control", "mod1"],
			f"f{vt}",
			lazy.core.change_vt(vt).when(func=lambda: qtile.core.name == "wayland"),
			desc=f"Switch to VT{vt}",
		)
	)


groups = [Group(i) for i in "123456789"]

for i in groups:
	keys.extend(
		[
			# mod + group number = switch to group
			Key(
				[mod],
				i.name,
				lazy.group[i.name].toscreen(),
				desc=f"Switch to group {i.name}",
			),
			# mod + shift + group number = switch to & move focused window to group
			Key(
				[mod, "shift"],
				i.name,
				lazy.window.togroup(i.name, switch_group=True),
				desc=f"Switch to & move focused window to group {i.name}",
			),
			# Or, use below if you prefer not to switch to that group.
			# # mod + shift + group number = move focused window to group
			# Key([mod, "shift"], i.name, lazy.window.togroup(i.name),
			#	 desc="move focused window to group {}".format(i.name)),
		]
	)

layouts = [
	layout.Columns(border_focus_stack=["#d75f5f", "#8f3d3d"], border_width=4),
	layout.Max(),
	# Try more layouts by unleashing below layouts.
	# layout.Stack(num_stacks=2),
	# layout.Bsp(),
	# layout.Matrix(),
	# layout.MonadTall(),
	# layout.MonadWide(),
	# layout.RatioTile(),
	# layout.Tile(),
	# layout.TreeTab(),
	# layout.VerticalTile(),
	# layout.Zoomy(),
]

widget_defaults = dict(
	font="sans",
	fontsize=12,
	padding=3,
)
extension_defaults = widget_defaults.copy()

logo = os.path.join(os.path.dirname(libqtile.resources.__file__), "logo.png")
bottomBar=bar.Bar(
	[
		widget.WindowCount(show_zero=True),
		widget.CurrentLayout(width=90, fmt='{}-----'),
		widget.GroupBox(this_current_screen_border='c72828', disable_drag=True, visible_groups='1234'),
		widget.WindowName(mouse_callbacks={'Button1':lazy.window.opacity(1), 'Button3': lazy.window.opacity(0.5)}),
		# NB Systray is incompatible with Wayland, consider using StatusNotifier instead
		# widget.StatusNotifier(),
		widget.Wttr(location={'London':'Mmm'}, format='%t %C', foreground='ff8f00'),
		widget.Systray(),

		widget.Clock(format='%b %d %a', foreground='#FF8f8f'),
		widget.Clock(format='%I:%M %p', foreground='#FF3f3f'),
		widget.QuickExit(countdown_start=2400),
	],
	40,
	# border_width=[2, 0, 2, 0],  # Draw top and bottom borders
	# border_color=["ff00ff", "000000", "ff00ff", "000000"]  # Borders are magenta
)

mainScreen = Screen(
	bottom = bottomBar,
)


sideScreen = Screen(
)

screens = [mainScreen, sideScreen]

def focus_window_under_mouse(qtile):
	x, y = qtile.core.get_mouse_position()
	screen = qtile.current_screen

	for win in screen.group.windows:
		if win.x <= x <= win.x + win.width and \
		   win.y <= y <= win.y + win.height:
			screen.group.focus(win, warp=False)
			return win.get_position()
	return qtile.current_window.get_position()



# Drag floating layouts.
mouse = [
	Drag([win], "Button1", lazy.window.set_position_floating(),
		 start=lazy.window.get_position()),

# Move tiling. Keep but change to Button2
# 	Drag([win], "Button2", lazy.window.set_position(), start=lazy.window.get_position()),

Drag(
	[win], "Button2",
	lazy.window.set_position(),
	start=lazy.function(focus_window_under_mouse)
),

	Drag([win], "Button3", lazy.window.set_size_floating(),
		 start=lazy.window.get_size()),
	Click([win], "Button2", lazy.window.bring_to_front()),
]

dgroups_key_binder = None
dgroups_app_rules = []  # type: list
follow_mouse_focus = False
bring_front_click = False
floats_kept_above = True
cursor_warp = False
floating_layout = layout.Floating(
	float_rules=[
		# Run the utility of `xprop` to see the wm class and name of an X client.
		*layout.Floating.default_float_rules,
		Match(wm_class="confirmreset"),  # gitk
		Match(wm_class="makebranch"),  # gitk
		Match(wm_class="maketag"),  # gitk
		Match(wm_class="ssh-askpass"),  # ssh-askpass
		Match(title="branchdialog"),  # gitk
		Match(title="pinentry"),  # GPG key password entry
	]
)
auto_fullscreen = True
focus_on_window_activation = "smart"
focus_previous_on_window_remove = False
reconfigure_screens = True

# If things like steam games want to auto-minimize themselves when losing
# focus, should we respect this or not?
auto_minimize = True

#  ____  _             _               
# / ___|| |_ __ _ _ __| |_ _   _ _ __  
# \___ \| __/ _` | '__| __| | | | '_ \ 
#  ___) | || (_| | |  | |_| |_| | |_) |
# |____/ \__\__,_|_|   \__|\__,_| .__/ 
#                               |_|    

import os
import subprocess
from libqtile import hook

def spo(a):
	try:
		subprocess.Popen(a)
	except:
		pass

@hook.subscribe.startup_once
def autostart():
	spo(['albert'])
	spo(['xset', 'r', 'rate', '300', '50'])
	spo(['syncthing']) 
	spo(['ibus-daemon'])
	spo(['picom'])
	spo(['copyq']) 
	spo(['flameshot']) 
	spo(['libinput-gestures']) 
	spo(['/usr/bin/lxpolkit'])


@hook.subscribe.client_new
def fix_group(window):
	if "albert" in window.get_wm_class(): 
		group = qtile.current_group
		if window.group != group:
			window.togroup(group.name)
		window.cmd_bring_to_front()
		window.cmd_focus()

# When using the Wayland backend, this can be used to configure input devices.
wl_input_rules = None

# xcursor theme (string or None) and size (integer) for Wayland backend
wl_xcursor_theme = None
wl_xcursor_size = 24

idle_inhibitors = []  # type: list

# XXX: Gasp! We're lying here. In fact, nobody really uses or cares about this
# string besides java UI toolkits; you can see several discussions on the
# mailing lists, GitHub issues, and other WM documentation that suggest setting
# this string if your java app doesn't work correctly. We may as well just lie
# and say that we're a working one by default.
#
# We choose LG3D to maximize irony: it is a 3D non-reparenting WM written in
# java that happens to be on java's whitelist.
wmname = "LG3D"

