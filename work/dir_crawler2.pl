#!/usr/bin/perl -w

use strict;
use Getopt::Std;

my %cli_opts = ();
my $start_path = ".";
my $sought_ext = "feature";
my $counter = 0;

getopt('ehs', \%cli_opts);

#&help() if (exists $cli_opts{'h'});
&help if (keys %cli_opts == 0);

if (exists $cli_opts{'s'}) {
    $start_path = $cli_opts{'s'};
} else {
    print STDERR "No path has been given, starting from pwd.\n";
}

if (exists $cli_opts{'e'}) {
    $sought_ext = $cli_opts{'e'};
} else {
    print STDERR "No extension has been given, searching for '$sought_ext'\n";
}

my @collected_files = ();

&dir_crawler($start_path,$sought_ext);
print "$_\n" for @collected_files;

sub help() {
    print << "EOF";
Usage:
    $0 [-e][-h][-s]
	-e: file extension to search for (default: "feature")
	-h: this help
	-s: the path where to start from (default: .)
EOF
}

sub dir_crawler {
    unless ($_[0] =~ /.*\/$/) {
	$_[0] .= '/';
    }
    my @dir = <$_[0]*>;
    for (@dir) {
	if (/.*\.$_[1]$/) {
	    push @collected_files,$_;
	}
	exit(1) if ($counter > 10);
	&dir_crawler($_,$_[1]) if -d;
    }
}
