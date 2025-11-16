UNAME := $(shell uname)

ifeq "$(UNAME)" "Linux"
.DEFAULT_GOAL := linux
else ifeq "$(UNAME)" "Darwin"
.DEFAULT_GOAL := darwin
endif

packages-linux:
	paru -Sy --noconfirm - < packages.common.txt < packages.arch.txt

postinstall-linux:
	@echo "Linux postinstall"
	sudo ln -sf /usr/bin/pinentry-gnome3 /usr/local/bin/pinentry

packages-darwin:
	brew install $(shell cat packages.common.txt packages.macos.txt)

postinstall-darwin:
	@echo "Darwin postinstall"
	sudo ln -sf /opt/homebrew/bin/pinentry-mac /usr/local/bin/pinentry

common:
	stow --adopt */
	git restore .

linux: packages-linux common postinstall-linux

darwin: packages-darwin common postinstall-darwin

