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

use png_size;

{
    my ($img_file) = 'traffic.png';
    my ($width, $height, $id) = Png::Size::png_size($img_file);
    say "width: $width";
    say "height: $height";
    say "ID: $id";
}

