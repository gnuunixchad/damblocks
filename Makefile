BIN_SOURCE = bin
BIN_DEST = ~/.local/bin
RULES_SOURCE = etc/udev/rules.d
RULES_DEST = /etc/udev/rules.d
CRONTAB_BACKUP = ~/.config/crontab.damblocks.backup
CRONTAB_DAMBLOCKS= etc/crontab

install: install_bin install_rules install_cronjobs

install_bin:
	@mkdir -p $(BIN_DEST)
	@stow -R -d $(BIN_SOURCE) -t $(BIN_DEST) .

install_rules:
	@sudo mkdir -p $(RULES_DEST)
	@sudo cp $(RULES_SOURCE)/99-damblocks-* $(RULES_DEST)

install_cronjobs:
	@crontab -l > $(CRONTAB_BACKUP)
	@crontab $(CRONTAB_DAMBLOCKS)


uninstall: uninstall_bin uninstall_rules uninstall_cronjobs

uninstall_bin:
	@stow -D -d $(BIN_SOURCE) -t $(BIN_DEST) .

uninstall_rules:
	@sudo rm $(RULES_DEST)/99-damblocks-bluetooth.rules $(RULES_DEST)/99-damblocks-usb-audio.rules

uninstall_cronjobs:
	@crontab $(CRONTAB_BACKUP)


.PHONY: install install_bin install_rules install_cronjobs uninstall uninstall_bin uninstall_rules uninstall_cronjobs
