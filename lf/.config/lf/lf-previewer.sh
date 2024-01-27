#!/bin/sh
# https://pkg.go.dev/github.com/chrispenner/lf#hdr-Previewing_Files

case "$1" in
	# *.tar*) tar tf "$1";;
	# *.zip) unzip -l "$1";;
	# *.rar) unrar l "$1";;
	# *.7z) 7z l "$1";;
	# *.pdf) pdftotext "$1" -;;
	*) bat --paging=never --color=always --style=plain "$1";;
esac
