#!/usr/bin/env perl

use warnings;
use strict;
#use Modern::Perl;
use Carp;
use utf8;
use encoding 'utf8';

{
    my $false_name = 'Sparkles & Blue';

    print "Normal mode:\n";
    print "Boolean true!\n"  if      !! $false_name;
    print "Numeric false!\n" unless  0  + $false_name;
    print "String true!\n"   if      ''  . $false_name;
    print "\n";
}

{
    use Scalar::Util 'dualvar';
    my $false_name = dualvar 0, 'Sparkles & Blue';

    print "dualvar mode:\n";
    print "Boolean true!\n"  if      !! $false_name;
    print "Numeric false!\n" unless  0  + $false_name;
    print "String true!\n"   if      ''  . $false_name;
}
