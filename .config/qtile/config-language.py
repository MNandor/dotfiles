# Copyright (c) 2010 Aldo Cortesi
# Copyright (c) 2010, 2014 dequis
# Copyright (c) 2012 Randall Ma
# Copyright (c) 2012-2014 Tycho Andersen
# Copyright (c) 2012 Craig Barnes
# Copyright (c) 2013 horsik
# Copyright (c) 2013 Tao Sauvage
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.

#vim silent! loadview
#vim autocmd BufWinLeave * mkview



# https://docs.qtile.org/en/latest/manual/ref/widgets.html

from typing import List  # noqa: F401
from libqtile import bar, layout, widget, qtile
from libqtile.config import Click, Drag, Group, Key, Match, Screen, ScratchPad, DropDown
from libqtile.lazy import lazy
from libqtile.utils import guess_terminal
from libqtile.log_utils import logger

win = "mod4"
alt = "mod1"
ctrl = 'control'
shift = 'shift'
tilde = '/home/n'
terminal = guess_terminal()
bigterminal = "xfce4-terminal --zoom 3 --color-text=#FFFFFF --color-bg=#000000"

dmenu='dmenu -nb "#000000" -nf "#FF0000" -sf "#000000" -sb "#FF0000" -i -l 5'

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
# 	logger.warning(str(dir(qtile)))
	for window in qtile.current_group.windows:
		if window.floating:
			window.cmd_bring_to_front()
			window.cmd_focus()

wallpaper = tilde+'/Pictures/Wallpapers/battery-tux.png'

#  _  __              
# | |/ /___ _   _ ___ 
# | ' // _ \ | | / __|
# | . \  __/ |_| \__ \
# |_|\_\___|\__, |___/
#           |___/     

keys = [
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
	
	# Toggle between different layouts as defined below
	Key([win], "Tab", lazy.next_layout(), desc="Toggle between layouts"),

	Key([win], "c", lazy.window.kill(), desc="Kill focused window"),
	Key([win], "f", lazy.window.toggle_fullscreen(), desc="Toggle fullscreen"),
	Key([win, shift], "f", lazy.window.toggle_floating(), desc="Float focused window"),

	Key([win, "control"], "r", lazy.restart(), desc="Restart Qtile"),
	Key([win, "control"], "q", lazy.shutdown(), desc="Shutdown Qtile"),

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


	Key([win], "left", lazy.screen.prev_group(), desc="Previous workspace"),
	Key([win], "right", lazy.screen.next_group(), desc="Next workspace"),



	# Screenshots
# 	Key([], "Print", lazy.spawn("xfce4-screenshooter -cf")),
# 	Key([shift], "Print", lazy.spawn("xfce4-screenshooter -cr")),
# 	Key(['control'], "Print", lazy.spawn("xfce4-screenshooter -f")),
# 	Key(['control', shift], "Print", lazy.spawn("xfce4-screenshooter -r")),
# 	Key([], "Print", lazy.spawn("flameshot full --clipboard")),
# 	Key([shift], "Print", lazy.spawn("flameshot gui --clipboard")),
# 	Key(['control'], "Print", lazy.spawn("flameshot full")),
# 	Key(['control', shift], "Print", lazy.spawn("flameshot gui")),
	Key([], "Print", lazy.spawn("flameshot full --clipboard")),
	Key([ctrl], "Print", lazy.spawn("flameshot full")),
	Key([shift], "Print", lazy.spawn("flameshot gui")),

	# Screen Lock
	# Note: win-l is already is use
	Key([win], "o", lazy.spawn("slock")),

	Key([alt, "control"], 'tab', float_to_front, desc="Floating windows to front"),
	Key([win, "control"], 'tab', float_to_front, desc="Floating windows to front"),
	Key([win], 'up', float_to_front, desc="Floating windows to front"),
	Key([win], "down", lazy.layout.next(), desc="Move window focus to other window"),
	
]

#  _                           _     
# | |    __ _ _   _ _ __   ___| |__  
# | |   / _` | | | | '_ \ / __| '_ \ 
# | |__| (_| | |_| | | | | (__| | | |
# |_____\__,_|\__,_|_| |_|\___|_| |_|

run_logseq = '/home/n/Other/AppImages/Logseq-linux-x64-0.9.19.AppImage'
run_joplin = '/home/n/Other/AppImages/Joplin-2.9.17.AppImage'
run_firefox = 'firefox --profile /home/n/.mozilla/firefox/odrfifn6.School'
                                   
hotkeys = {
	'e': f'{terminal} -x ranger',
	'v': f'{bigterminal} -x vim -c startinsert',
}
for key in hotkeys.keys():
	value = hotkeys[key]
	a = Key([win], key, lazy.spawn(value), desc="Launch "+value)
	keys+=[a]

keys += [
	# Open terminal
]


#   ____                           
#  / ___|_ __ ___  _   _ _ __  ___ 
# | |  _| '__/ _ \| | | | '_ \/ __|
# | |_| | | | (_) | |_| | |_) \__ \
#  \____|_|  \___/ \__,_| .__/|___/
#                       |_|        

groups = [
	Group('Q', matches=[Match(wm_class=["Firefox"])]),
	Group('W', matches=[Match(wm_class=["Joplin"]), ]),
	Group('A', matches=[Match(wm_class=["anki"]), ]),
	Group('S', matches=[Match(wm_class=["Logseq"]), ]),
]
# the command to get the info like wm_class is 'xprop'

for num, i in enumerate(groups):
	keys.extend([
		# win + letter of group = switch to group
		Key([win], i.name, lazy.group[i.name].toscreen(),
			desc="Switch to group {}".format(i.name)),


		Key([win], str(num+1), lazy.group[i.name].toscreen(),
			desc="Switch to group {}".format(i.name)),

	])

# ScratchPads experimentation
# https://docs.qtile.org/en/latest/manual/config/groups.html
groups += [
	ScratchPad('scratchpad', [
		DropDown('tui-dd', 'xfce4-terminal --title="tui-dd" --command "taskwarrior-tui"', opacity=1, match=Match(title='tui-dd'), width=0.5, x=0.5, height=1, y=0),
		DropDown('nto-dd', 'xfce4-terminal --title="nto-dd" --command "vim"', opacity=1, match=Match(title='nto-dd'), width=0.5, x=0, height=1, y=0),
		]
	),
]
keys += [Key([], 'F2', lazy.group['scratchpad'].dropdown_toggle('nto-dd'), desc='Toggle scratchpad terminal')]
keys += [Key([], 'F3', lazy.group['scratchpad'].dropdown_toggle('tui-dd'), desc='Toggle scratchpad taskwarrior-tui')]

#  _                            _       
# | |    __ _ _   _  ___  _   _| |_ ___ 
# | |   / _` | | | |/ _ \| | | | __/ __|
# | |__| (_| | |_| | (_) | |_| | |_\__ \
# |_____\__,_|\__, |\___/ \__,_|\__|___/
#             |___/                     

layouts = [
	layout.Columns(border_focus_stack=['#5fd6d6', '#3d8f8f'], border_focus='#2222FF', border_normal='#000022', border_width=2, margin=2, insert_position=1),
	layout.Max(),
	# Try more layouts by unleashing below layouts.
# 	layout.Stack(num_stacks=2),
# 	layout.Bsp(),
# 	layout.Matrix(),
# 	layout.MonadTall(),
# 	layout.MonadWide(),
# 	layout.RatioTile(),
# 	layout.Tile(),
# 	layout.TreeTab(panel_width=960, section_bottom=200),
# 	layout.VerticalTile(),
# 	layout.Zoomy(),
]

widget_defaults = dict(
	font='sans',
	fontsize=12,
	padding=3,
)
extension_defaults = widget_defaults.copy()

#  _____           _ _                
# |_   _|__   ___ | | |__   __ _ _ __ 
#   | |/ _ \ / _ \| | '_ \ / _` | '__|
#   | | (_) | (_) | | |_) | (_| | |   
#   |_|\___/ \___/|_|_.__/ \__,_|_|   
                                    
def pollFunc1():
	return "WIP"

def pollFunc2():
	return "WIP"
def pollFunc4():
	command = 'xrandr | grep \\\\sconnected | wc -l | sed /1/d'
	ret = subprocess.check_output(command, shell=True).decode(encoding='utf-8').strip()
	return ret


def cancelTimer():
	pass

def stopTimer():
	pass

def openMarker():
	pass

def startTimer():
	pass

def redshiftOn():
	command = 'redshift -P -O 3000'
	subprocess.Popen([command], shell=True)

def redshiftOff():
	command = 'redshift -P -O 7000'
	subprocess.Popen([command], shell=True)

def xposition():
	smn = '''xrandr | grep HDMI | sed -e '/HDMI/!d' -e 's/\\([^ ]\\) .*/\\1/' '''
	smn = subprocess.check_output(smn, shell=True).decode(encoding='utf-8').strip()
	mmn = '''xrandr | grep eDP | sed -e '/eDP/!d' -e 's/\\([^ ]\\) .*/\\1/' '''
	mmn = subprocess.check_output(mmn, shell=True).decode(encoding='utf-8').strip()
	cmd = f'''xrandr --auto && xrandr --auto --output {smn}  --$(echo -e "left\\nright" | {dmenu})-of {mmn}'''
	
	command = f'notify-send {smn} {mmn}'
	subprocess.Popen([cmd], shell=True)

def xrotate():
	smn = '''xrandr | grep HDMI | sed -e '/HDMI/!d' -e 's/\\([^ ]\\) .*/\\1/' '''
	smn = subprocess.check_output(smn, shell=True).decode(encoding='utf-8').strip()

	cmd = f'echo -e "normal\nright\nleft" | {dmenu} |xargs xrandr --output {smn} --rotate'
	subprocess.Popen([cmd], shell=True)

def xbright():
	cmd = f'''echo -e "1%\n10%\n20%\n30%\n50%\n100%" | {dmenu} | xargs brightnessctl set'''

	subprocess.Popen([cmd], shell=True)



def xtablet():
	pass



# todo these could be separated better

cpink = 'ff00bf'
cyellow = 'ffbf00'
cteal = '40bfbf'
cgreen = '40bf00'
cgraph = '800000'

bottomBar=bar.Bar(
	[
		widget.WindowCount(show_zero=True),
		widget.CurrentLayout(),
		widget.GroupBox(this_current_screen_border='c72828', disable_drag=True, visible_groups='AQWS'),
		widget.Prompt(),
		widget.WindowName(mouse_callbacks={'Button1':lazy.window.opacity(1), 'Button3': lazy.window.opacity(0.5)}),
		widget.WidgetBox(widgets = [
			widget.TextBox('CPU', foreground=cgraph),
			widget.CPUGraph(fill_color=cgraph, graph_color='ff0000', border_color = cgraph),

			widget.TextBox('RAM', foreground=cgraph),
			widget.MemoryGraph(fill_color=cgraph, graph_color='ff0000', border_color = cgraph),

			widget.TextBox('SWP', foreground=cgraph),
			widget.SwapGraph(fill_color=cgraph, graph_color='ff0000', border_color = cgraph),

			widget.TextBox('HDD', foreground=cgraph),
			widget.HDDBusyGraph(fill_color=cgraph, graph_color='ff0000', border_color = cgraph),

			widget.TextBox('NET', foreground=cgraph),
			widget.NetGraph(fill_color=cgraph, graph_color='ff0000', border_color = cgraph),
			
			],
			close_button_location='right',
			foreground = cgraph
		),
		widget.Cmus(fmt='{}', update_interval=2, play_color=cgreen),
		widget.Notify(background='#FF0000', foreground='#000000'),
		widget.GenPollText(func=pollFunc1, update_interval=1, mouse_callbacks={'Button1': stopTimer, 'Button2': cancelTimer, 'Button3': startTimer}, foreground='#00AAFF'),
		widget.Systray(),
		widget.GenPollText(func=pollFunc4, update_interval=1, mouse_callbacks={'Button1': xposition, 'Button2':xtablet, 'Button3':xrotate}, foreground='#FFFFFF'),
		widget.PulseVolume(foreground = cpink, fmt='?{}'),
		widget.Battery(format='{char}{percent:2.0%}', foreground=cteal, notify_below=0.55, low_percentage=0.15, charge_char='+', discharge_char='-'),
		widget.Backlight(backlight_name='intel_backlight', foreground=cyellow, fmt='*{}', mouse_callbacks={'Button1':redshiftOff, 'Button3':redshiftOn, 'Button2':xbright}),
		widget.Pomodoro(),
		widget.Clock(format='%b %d %a', foreground='#FF8f8f'),
		widget.Clock(format='%I:%M %p', foreground='#FF3f3f'),
		widget.QuickExit(),
	],
	24,
)

#   ___  _   _               
#  / _ \| |_| |__   ___ _ __ 
# | | | | __| '_ \ / _ \ '__|
# | |_| | |_| | | |  __/ |   
#  \___/ \__|_| |_|\___|_|   
                           
mainScreen = Screen(
	bottom = bottomBar,
	wallpaper=wallpaper
)


sideScreen = Screen(
	wallpaper=wallpaper
)

screens = [mainScreen, sideScreen]


# Drag floating layouts.
mouse = [
	Drag([win], "Button1", lazy.window.set_position_floating(),
		 start=lazy.window.get_position()),
	Drag([win], "Button3", lazy.window.set_size_floating(),
		 start=lazy.window.get_size()),
	Click([win], "Button2", lazy.window.bring_to_front())
]

dgroups_key_binder = None
dgroups_app_rules = []  # type: List
follow_mouse_focus = False
bring_front_click = False
cursor_warp = False
floating_layout = layout.Floating(float_rules=[
	# Run the utility of `xprop` to see the wm class and name of an X client.
	*layout.Floating.default_float_rules,
	Match(wm_class='confirmreset'),  # gitk
	Match(wm_class='makebranch'),  # gitk
	Match(wm_class='maketag'),  # gitk
	Match(wm_class='ssh-askpass'),  # ssh-askpass
	Match(title='branchdialog'),  # gitk
	Match(title='pinentry'),  # GPG key password entry
	Match(wm_class='guake'),
	Match(title='timew-popup'),
	Match(title='thunar'),
	Match(wm_class='nemo'),
	Match(wm_class='Conky'),
])

auto_fullscreen = True
focus_on_window_activation = "smart"
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
	spo(['xset', 'r', 'rate', '300', '50'])
	spo(['syncthing']) 
	spo(['ibus-daemon'])
	spo(['picom'])
	spo(['copyq']) 
	spo(['flameshot']) 
	spo(['libinput-gestures']) 
	spo(['anki']) 
	spo(run_firefox.split()) 
	spo([run_logseq]) 
	spo([run_joplin])
	spo(['optimus-manager-qt']) 




# XXX: Gasp! We're lying here. In fact, nobody really uses or cares about this
# string besides java UI toolkits; you can see several discussions on the
# mailing lists, GitHub issues, and other WM documentation that suggest setting
# this string if your java app doesn't work correctly. We may as well just lie
# and say that we're a working one by default.
#
# We choose LG3D to maximize irony: it is a 3D non-reparenting WM written in
# java that happens to be on java's whitelist.
wmname = "LG3D"
