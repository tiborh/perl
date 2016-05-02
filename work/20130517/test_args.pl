#!/usr/bin/perl -w

use strict;
use Cwd;
use Time::Piece;
use File::Basename;
use Getopt::Std;

 my ($in_path,$out_filename,$input_filename,$story_filename) = &test_args();
 if ($in_path == -1 && $input_filename == -1) {
     print "No valid input has been given. Either -d or -i should be valid.\n";
     exit 1;
 }

sub test_args {
    our %opts = ();
    my $the_input_file = -1;
    my $input_dir_path = -1;
    my $story_file_out = -1;
    my $default_out = -1;

    getopts('d:hi:o:s:', \%opts);

    if (!%opts or $opts{"h"}) {
	&usage();
	exit(1);
    } elsif (exists($opts{"i"})) {
	if (!defined($opts{"i"})) {
	    print STDERR "-i: a filename needs to be specified.\n";
	    exit(1);
	} elsif (! -e $opts{"i"}) {
		print STDERR "-i: the name of an existing file is needed.\n";
		exit(1);
	} else {
		$the_input_file = $opts{"i"};
	}
    } elsif (!exists($opts{"d"}) or !defined($opts{"d"})) {
	print STDERR "-d <directory> needs to be specified\n";
	exit(1);
    } elsif (-e $opts{"d"} and -d $opts{"d"}) {
	$input_dir_path = $opts{"d"};
    } else {
	print "-d <input directory>: needs to be a valid directory\n";
	exit(1);
    }

    if (exists($opts{"s"})) {
	if (defined($opts{"s"})) {
	    $story_file_out = $opts{"s"};
	} else {
	    $story_file_out = "story_files_".&get_timestamp().".txt";
	}
    }
    
    if (exists($opts{"o"})) {
	if (defined($opts{"o"})) {
	    $default_out = $opts{"o"};
	} else {
	    $default_out = "./output_".&get_timestamp().".xml";
	}
    }
				   
    return ($input_dir_path, $default_out, $the_input_file, $story_file_out);
}

sub usage {
print STDERR <<EOF;

Usage:
$0 -d <directory to explore> [-h] [-o [<output filename (with path)>]] [-s [<name of txt file for story file paths>]]
EOF
exit(1);
}
