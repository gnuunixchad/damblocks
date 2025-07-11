# <img src="./misc/damblocks-repo.png" width="24"/> damblocks
My *Simple bar* script for displaying status information in [river](https://codeberg.org/river/river) and [dwl](https://codeberg.org/dwl/dwl).

![screenshot](./dam-damblocks.png)


Fork of [sbar](https://github.com/pystardust/sbar). Written in POSIX SHELL.

## Features
* Modules update with variable timing.
* Signalling to update modules when needed.

# Usage
```sh
# Start in river with my build of dam that can be found on
# https://codeberg.org/unixchad/dam
# https://github.com/gnuunixchad/dam
pgrep 'dam' || riverctl spawn "$HOME/.local/bin/damblocks | dam"

# Start in my build of dwl with the bar patch
# https://codeberg.org/unixchad/dwl
# https://github.com/gnuunixchad/dwl
alias dl="exec ssh-agent ${HOME}/.local/bin/damblocks | /usr/local/bin/dwl"
```

> [!NOTE]
> Some functions depends on files generated my personal scripts from a cronjob,
> which can be found inside the `.local/bin/` directory from my `dotfiles`([codeberg](https://codeberg.org/unixchad/dotfiles)/[github](https://github.com/gnuunixchad/dotfiles)).

# Setup

* Add bar module as a function. Make sure to assign it to a variable.
```
update_cpu () { 
	cpu="$( grep -o "^[^ ]*" /proc/loadavg )" 
}
```

* Modify display function to change the positioning of output.
```
display () { 
	xsetroot -name " [$weather] [$memory $cpu] [$bat] [$backlight] [$vol] $time "
}
```
You can use printf instead of xsetroot to feed it into some other bar like lemonbar.

* If signalling needed then add
```
trap "update_cpu;display" "RTMIN+6"
```
* this will update cpu when signal 40=34+6 is given to the script (RTMIN = 34)
* to update it from external commands
```
kill -40 "$(cat ~/.cache/pidofbar)"
```
* Example from my sxhkrc
```
{XF86AudioRaiseVolume,XF86AudioLowerVolume}
	pulsemixer --change-volume {+,-}5 ; \
	kill -34 "$(cat ~/.cache/pidofbar)"
```


* Add the update information in the while loops as follows
``` 
[ $((sec % 60)) -eq 2 ] && update_cpu
```
To update item ever 60 seconds with an offset of 2 seconds.


