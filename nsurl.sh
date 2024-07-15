#!/bin/bash

# notify-send a clickable URL to the desktop

export DISPLAY=:0.0

bins=(
    curl:curl
    notify-send:libnotify
    xmllint:libxml2
)
for bin in "${bins[@]}" ; do
    [ ! -f $( which "${bin%:*}" >/dev/null ) ] &&
	echo "Please install ${bin#*:}" &&
	exit 1
done

[ -z "$1" ] &&
    echo "No URL provided" &&
    exit 2

title=$( curl "$1" 2>/dev/null | xmllint --html --xpath //title - 2>/dev/null )
title="${title#*>}"
title="${title%<*}"

notify-send -t 0 \
	    -i /usr/share/icons/oxygen/base/48x48/mimetypes/text-html.png \
	    "URL" \
	    '<a href="'"$1"'">'"${title:-No title}"'</a>'
