#!/bin/sh

case "$1" in
*.tar*) tar tf "$1" ;;
*.zip) unzip -l "$1" ;;
*.rar) unrar-free -t "$1" ;;
*.7z) 7z l "$1" ;;
*.pdf) pdftotext "$1" - ;;
*) bat --paging=never --style=numbers --color=always --terminal-width $(($2 - 1)) "$1" ;;
esac
