#!/usr/bin/env perl

use warnings;
use 5.014; 			# implies strict
use Carp;
use utf8;
use autodie;

binmode(STDOUT, ":utf8");

#the following two needs installation:
#use Modern::Perl;
#use Test::More;

use File::ReadBackwards;
my $backwards = File::ReadBackwards->new( '/var/log/apache2/error.log' );
my $last_nonblank_line = $backwards->readline;
print "$last_nonblank_line\n";
