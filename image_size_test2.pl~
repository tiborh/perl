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
    my ($width, $height, $id) = imgsize($img_file);
    #open(IN, $img_file) or die "Cannot open $img_file: $!";
    #($width, $height, $id) = imgsize(\*IN);
    say "width: $width";
    say "height: $height";
    say "ID: $id";
}
