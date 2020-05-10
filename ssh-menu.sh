#!/bin/sh

menu ()
{
    for h in ${HOSTS[@]} ; do
	let i+=1
	echo -n $i $h ''
    done
}

HEIGHT=$( tput lines )
HEIGHT=$[HEIGHT-4]
WIDTH=$( tput cols )
WIDTH=$[WIDTH-8]
FORM=$[HEIGHT-4]
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

exec 3>&1
SELECTED=$(
    dialog --title 'SSH Menu'			      \
	   --menu 'Destination:' $HEIGHT $WIDTH $FORM \
	   $( menu ) 2>&1 1>&3
    [ $? -ne 0 ] && exit $?
)
exec 3>&-

let SELECTED-=1
ssh ${HOSTS[$SELECTED]}
