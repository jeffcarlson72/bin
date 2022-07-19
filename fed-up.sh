#!/bin/sh

[ $( id -u ) == 0 ] || echo "Run $0 as root" && exit

dnf install dnf-plugin-system-upgrade dnf-utils rpmconf

. /etc/os-release 
target=$[VERSION_ID+1]

dnf upgrade --refresh

rpmconf -a
rpmconf -c

package-cleanup --leaves
read -p "Proceed with removal of leaf packages? " REPLY

case $REPLY in
    Y|y)
	package-cleanup --leaves | xargs dnf remove -y
	;;
esac

unset REPLY

package-cleanup --orphans
read -p "Proceed with removal of orphan packages? " REPLY

case $REPLY in
    Y|y)
	package-cleanup --orphans | xargs dnf remove -y
	;;
esac

unset REPLY

read -p "Proceed with system upgrade? " REPLY
case $REPLY in
    Y|y)
	# fedora-upgrade
	dnf system-upgrade download --refresh --releasever=$target
	;;
esac

