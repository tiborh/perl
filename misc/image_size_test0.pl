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

use Image::Size qw(:all);
my ($img_file) = 'traffic.gif';

{
    open(STDIN, $img_file) or die "Cannot open $img_file: $!";
    my ($width, $height, $id) = imgsize(\*STDIN);
    say "width: $width";
    say "height: $height";
    say "ID: $id";
}
