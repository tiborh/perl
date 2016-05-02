#!/usr/bin/env perl

use warnings;
use 5.014;
use utf8;

binmode(STDOUT, ":utf8");

our $x = "initial x";
my $y = "initial y";
# local $z = "initial z";       # can be use only for the localisation of global

print "before first call\n";
&test();			# works
#test();				# works
#&test;				# works

{
    print "in temporary scope\n";
    local $x = $x;		# needed to have it initialised
    my $y = "temporary y";
    print "localised x, lexical y\n";
    &test();
    print "changed localised x\n";
    $x = "temporary x";	# overwrites main's x
    &test();
}

print "after temporary scope\n";
&test();
print "End status: $x, $y\n";

sub test() {
    print "in sub\n";
    print "\t",$x,"\n";		# takes $x from main, even if that is "my"
    print "\t",$y,"\n";
    my $x = "sub x";		# masks main's x
    $y = "sub y";		# changes original lexical variable
    print "\t",$y,"\n";
    print "\t",$x,"\n";
    print "\t",$main::x,"\n";	# does not work with "my"
}
