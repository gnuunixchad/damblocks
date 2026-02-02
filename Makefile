BIN_SOURCE = bin
BIN_DEST = ~/.local/bin
RULES_SOURCE = etc/udev/rules.d
RULES_DEST = /etc/udev/rules.d
CRONTAB_BACKUP = ~/.config/crontab.damblocks.backup
CRONTAB_DAMBLOCKS= etc/crontab
COMP_SOURCE = completions
COMP_DEST = /usr/local/share

install: install_bin install_rules install_cronjobs install_completions

install_bin:
	@mkdir -p $(BIN_DEST)
	@stow -R -d $(BIN_SOURCE) -t $(BIN_DEST) .

install_rules:
	@sudo mkdir -p $(RULES_DEST)
	@sudo cp $(RULES_SOURCE)/99-damblocks-* $(RULES_DEST)

install_cronjobs:
	@crontab -l > $(CRONTAB_BACKUP)
	@crontab $(CRONTAB_DAMBLOCKS)

install_completions:
	@sudo mkdir -p $(COMP_DEST)/bash-completion/completions
	@sudo install -m 644 $(COMP_SOURCE)/_damblocks.bash $(COMP_DEST)/bash-completion/completions/_damblocks.bash
	@sudo mkdir -p $(COMP_DEST)/zsh/site-functions
	@sudo install -m 644 $(COMP_SOURCE)/_damblocks.zsh $(COMP_DEST)/zsh/site-functions/_damblocks.zsh


uninstall: uninstall_bin uninstall_rules uninstall_cronjobs uninstall_completions

uninstall_bin:
	@stow -D -d $(BIN_SOURCE) -t $(BIN_DEST) .

uninstall_rules:
	@sudo rm $(RULES_DEST)/99-damblocks-bluetooth.rules $(RULES_DEST)/99-damblocks-usb-audio.rules

uninstall_cronjobs:
	@crontab $(CRONTAB_BACKUP)

uninstall_completions:
	@sudo rm $(COMP_DEST)/bash-completion/completion/_damblocks.bash $(COMP_DEST)/zsh/site-functions/_damblocks.zsh


.PHONY: install install_bin install_rules install_cronjobs install_completions uninstall uninstall_bin uninstall_rules uninstall_cronjobs uninstall_completions
