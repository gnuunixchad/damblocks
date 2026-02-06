# <img src="./misc/damblocks-repo.png" width="24"/> damblocks
Plain text status line generator written in POSIX shell, fork of [sbar](https://github.com/pystardust/sbar).

![screenshot](./dam-damblocks.png)

### Features
- with individual update intervals and signal support
- supporting stdin, fifo and xsetroot
- Each module is only updated when needed, instantly
- Restart damblocks with [reload](./bin/reload)

### Modules
- time and date
- battery or AC power supply, bluetooth battery
- brightness level, microphone volume, speaker volume
- wifi signal, ethernet connection
- memory usage, cpu usage, cpu temperature, cpu fan speed
- disk usage on root and home partition
- pacman update count, tty login count, system uptime
- calcurse coming event count, newsboat unread count, maildir unread count
- weather report
- mpd music title

## Dependency
| | |
|:---|:---|
| depends | ttf-nerd-fonts-symbols wireplumber brightnessctl coreutils sed grep awk curl cronie udev |
| suggests | dash bluez-utils isync newsboat calcurse mpc wob xob stow |

Every function that supports signaling depends on one or more of:
  1. [scripts](./bin/)
  2. [udev rules](etc/udev/rules.d/)
  3. [cronjobs](./etc/crontab)

Specific dependencies are listed in the SIGNALING session in this script.

## Installation
To mange all the scripts, udev rules and cronjobs:
```sh
# no sudo, scripts and cronjobs are installed as current user instead of root
# install
make install
# uninstall
make uninstall
```

## Usage
- output to stdin by default
- `--fifo` redirects to `${XDG_RUNTIME_DIR}/damblocks.fifo`
- `--xsetroot` sets the X root window title
### river-classic with dam
```sh
# river-classic/init
# see bin/dam-run
riverctl spawn dam-run
```

### river with kwm
```sh
# river/init
damblocks --fifo &
killall -q mpc
damblocks-mpdd
```

### dwm
```sh
# .xinitrc
damblocks --xsetroot &
exec dwm
```

### dwl with bar patch
```sh
damblocks | dwl
```

### sway with swaybar
```sh
bar {
    status_command damblocks
}

exec_always "killall -q mpc; damblocks-mpdd"
```
