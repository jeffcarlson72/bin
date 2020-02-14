#!/bin/bash

output()
{
    tput $1 $2
    printf " %3d" $2
    tput sgr0
}

show()
{
    C=$[${1}+${2}]
    if [ -z "$BGONLY" ] ; then
        output setaf $C
    fi
    if [ -z "$FGONLY" ] ; then
        output setab $C
    fi
}

usage()
{
    echo "$0 [-b] [-c] [-f]"
    echo "    -b - print background colors only"
    echo "    -c - print the extended color palate only"
    echo "    -f - print foreground colors only"
    echo "    -h - print this help and exit"
    echo "Don't use -b and -f together"
    exit 0
}

while getopts "bcfh" OPT ; do
    case $OPT in
        b)
            BGONLY=1
            ;;
        c)
            COLORS=1
            ;;
        f)
            FGONLY=1
            ;;
        h)
            usage
            ;;
    esac
done
shift $[OPTIND-1]

if [ -n "$BGONLY" -a -n "$FGONLY" ] ; then
    usage
fi

if [ -n "$COLORS" ] ; then
    for (( A=16 ; A<232 ; A=(A+6) )) ; do
        for B in {0..5} ; do
	    show $A $B
        done
        echo
    done
else
    for A in {0..31} ; do
        for (( B=0 ; B<255 ; B=(B+32) )) ; do
	    show $A $B
        done
        echo
    done
fi
