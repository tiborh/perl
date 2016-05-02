#!/usr/bin/perl -w

use strict;
use Cwd;
use Time::Piece;
use File::Basename;
use Getopt::Std;


my ($in_path,$out_path) = &test_args();
print "in path: $in_path\nout_path: $out_path";

sub test_args {
    our %opts = ();
    my $default_out = "./output_".&get_timestamp().".txt";

    getopts('d:f:h', \%opts);

    if (!%opts or $opts{"h"}) {
	&usage();
	exit(1);
    } elsif (!exists($opts{"d"}) or !defined$opts{"d"}) {
	print "-d<directory> needs to be specified\n";
	exit(1);
    }
				   
    return ($opts{"d"}, (((exists($opts{"f"}) and defined$opts{"f"})) ? $opts{"f"} : $default_out));
}

sub usage {
print STDERR <<EOF;

Usage:
$0 -d <directory to explore> [-f <file with filanames>] [-h]
EOF
exit(1);
}

sub get_timestamp {
    my @art = localtime(time);
    my $timestamp = sprintf("%4d%02d%02d_%02d%02d%02d",$art[5]+1900,++$art[4],$art[3],$art[2],$art[1],$art[0]);

    return $timestamp;
}
