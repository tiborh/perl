#!/usr/bin/perl -w
##!/usr/bin/perl -w

use strict;

my $fh;
my $fm = ">";
my $timestamp = &get_timestamp;
my $fn = "dump_$timestamp.sgml";

open($fh,$fm,$fn) or die "Cannot open $fn: $!";

&write_into_file($fh);

print "data has been written into $fn\n";

close $fh;

sub get_timestamp {
    my @art = localtime(time);
    my $timestamp = sprintf("%4d%02d%02d_%02d%02d%02d",$art[5]+1900,++$art[4],$art[3],$art[2],$art[1],$art[0]);

    return $timestamp;
}

sub write_into_file {
    my $fh = $_[0];

    print $fh "something stupid\n";
}
