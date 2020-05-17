#!/bin/sh

[ -z "$TERMINAL" ] && TERMINAL=xterm
KNOWNHOSTS=(
    /etc/ssh/ssh_known_hosts
    $HOME/.ssh/known_hosts
)

HOSTS=(
    $(
	awk '{ print $1 | "cut -d, -f1" }' ${KNOWNHOSTS[@]} |
	    sort -u					    |
	    egrep -iv 'git(hub|lab)|bitbucket'
    )
)

SELECTED=$(
    zenity --title "SSH Menu"	  \
	   --text "Choose a host" \
	   --list		  \
	   --column "Destination" \
	   ${HOSTS[@]} 2>/dev/null 
)

$TERMINAL -e "ssh $SELECTED" &
