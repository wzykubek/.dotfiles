UNAME := $(shell uname)

ifeq "$(UNAME)" "Linux"
.DEFAULT_GOAL := linux
else ifeq "$(UNAME)" "Darwin"
.DEFAULT_GOAL := darwin
endif

packages-linux:
	paru -Sy --noconfirm --needed - < packages.{common,paru}.txt

postinstall-linux:
	sudo ln -sf /usr/bin/pinentry-gtk /usr/local/bin/pinentry
	xdg-user-dirs-update

packages-darwin:
	xargs brew install < packages.{common,brew}.txt

postinstall-darwin:
	sudo ln -sf /opt/homebrew/bin/pinentry-mac /usr/local/bin/pinentry

common:
	bat cache --build

linux: packages-linux common postinstall-linux

darwin: packages-darwin common postinstall-darwin

