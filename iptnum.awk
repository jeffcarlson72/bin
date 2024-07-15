#!/bin/awk -f

# This script reads in iptables-save format from stdin and appends
# (commented) rule numbers to stdout.

# Tables are declared starting with an asterisk.  Reset all rule
# numbers on a new table.
/^\*/ {
    delete counter
}

# Rules begin with the APPEND command.  Number these.
$1 == "-A" {
    print $0, "#", ++counter[$2]
}

# Print all other lines without modification.
$1 != "-A" {
    print
}
