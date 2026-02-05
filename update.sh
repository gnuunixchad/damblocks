#!/usr/bin/sh
# @author nate zhou
# @since 2026
# update.sh - update files in damblocks repo

dotfiles="${HOME}/doc/unixchad/dotfiles"
damblocks="${HOME}/doc/unixchad/damblocks"

scripts="audio bright calcurse-num-cron checkupdates-cron dam-run damblocks-mpdd mbs mbs-cron mutt news newsboat-num-cron newsboat-update-cron wobd wttr reload"
rules="99-damblocks-bluetooth.rules 99-damblocks-usb-audio.rules"
shells="bash zsh"

update_damblocks() {
    cp ${dotfiles}/.local/bin/damblocks ${damblocks}
}

update_bin() {
    mkdir -p ${damblocks}/bin
    for script in $scripts; do
        cp ${dotfiles}/.local/bin/${script} ${damblocks}/bin/
    done
}

update_rules() {
    mkdir -p ${damblocks}/etc/udev/rules.d
    for rules in $rules; do
        cp ${dotfiles}/etc/udev/rules.d/$rules \
              ${damblocks}/etc/udev/rules.d/
    done
}

update_cronjobs() {
    mkdir -p ${damblocks}/etc
    cp  ${dotfiles}/.config/crontab.example ${damblocks}/etc/crontab
}

update_completions() {
    mkdir -p ${damblocks}/completions
    for shell in $shells; do
        cp ${dotfiles}/.config/${shell}/completions/_damblocks.${shell} \
              ${damblocks}/completions/_damblocks.${shell}
    done
}

update_damblocks; update_bin; update_rules; update_cronjobs; update_completions
