#!/bin/bash

output()
{
    tput $1 $2
    printf " %3d" $2
    tput sgr0
}

show()
{
    c=$[${1}+${2}]
    if [ -z "$bgonly" ] ; then
        output setaf $c
    fi
    if [ -z "$fgonly" ] ; then
        output setab $c
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
            bgonly=1
            ;;
        c)
            colors=1
            ;;
        f)
            fgonly=1
            ;;
        h)
            usage
            ;;
    esac
done
shift $[OPTIND-1]

if [ -n "$bgonly" -a -n "$fgonly" ] ; then
    usage
fi

if [ -n "$colors" ] ; then
    for (( a=16 ; a<232 ; a=(a+6) )) ; do
        for b in {0..5} ; do
	    show $a $b
        done
        echo
    done
else
    for a in {0..31} ; do
        for (( b=0 ; b<255 ; b=(b+32) )) ; do
	    show $a $b
        done
        echo
    done
fi
