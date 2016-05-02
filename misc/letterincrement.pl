#!/usr/bin/env perl

use warnings;
use v5.14; 			# implies strict
use Carp;
use utf8;
use autodie;
#the following two needs installation:
#use Modern::Perl;
#use Test::More;

binmode(STDOUT, ":utf8");

my $a = "a";
say "my letter is: '$a'";
++$a;
say "after increment: '$a'";
$a = 'z';
say "if my letter is '$a'";
++$a;
say "it becomes '$a'";

$a = '/1';
my $b = substr($a,1);
++$b;
say "/1 incremented (with a little trick) to '/$b'";
