#!/usr/bin/env perl

# this script was written to fight a bug in openssl 1.0.1g pod files: =item [0-9]+ was not accepted

use warnings;
use 5.014; 			# implies strict
#use strict;
use Carp;
use utf8;
#use encoding 'utf8';    # depracated
use autodie;
#use Modern::Perl;
#use Test::More;

my $directory = '../ssl';
opendir(DIR, $directory) or die $!;
while (my $file = readdir(DIR)) {
    next if $file eq '.' or $file eq '..';
    print "$file\n";
    my ($fh_in,$fh_out);
    open($fh_in,'<',"$directory/$file") or die "cannot open $file, $!";
    open($fh_out,'>',"$file") or die "cannot open $file, $!";
    while(<$fh_in>) {
	s/^(=item\s+)([0-9]+)/$1($2)/;
	print $fh_out $_;
    }
    close($fh_out);
    close($fh_in);
}
closedir(DIR);
