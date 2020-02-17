#!/usr/bin/perl -w

use strict;
use Text::Wrap;

my $line;
open(IN, $ARGV[0]) || die "Ouch! $!";
while (<IN>) {
    chomp;
    if (/^\S/) {
	print(wrap("\n", "\t", $line));
	$line = $_;
    } else {
	$line .= $_;
    }
}
