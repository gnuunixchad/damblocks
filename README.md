# <img src="./misc/damblocks-repo.png" width="24"/> damblocks
Plain text status line generator written in POSIX shell, fork of [sbar](https://github.com/pystardust/sbar).

![screenshot](./dam-damblocks.png)

### Features
- individual update intervals and signals
- individual modules only updated when needed, instantly
- supporting stdin, fifo and xsetroot
- supporting Wayland, Xorg and TTY
- restart damblocks with [reload](./bin/reload)

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
Use [dam-run](./bin/dam-run).

### kwm on river
[kwm](./https://github.com/kewuaa/kwm) can read from stdin:
```sh
damblocks | kwm &
killall -q mpc
damblocks-mpdd
```
or a named pipe:
```sh
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

### i3/sway bar
```sh
# .config/{i3,sway}/config
bar {
    status_command damblocks
}

exec_always "killall -q mpc; damblocks-mpdd"
```

### dvtm
```sh
damblocks --fifo &
dvtm -s ${XDG_RUNTIME_DIR}/damblocks.fifo
```
