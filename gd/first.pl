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

use GD;
use my_gd;

# create a new image
my $im = new GD::Image(100,100);

# allocate some colors
my $colours = MyGd::define_colours($im);

# make the background transparent and interlaced
$im->transparent($colours->{white});
$im->interlaced('true');

# Put a black frame around the picture
$im->rectangle(0,0,99,99,$colours->{black});

# Draw a blue oval
$im->arc(50,50,95,75,0,360,$colours->{blue});

# And fill it with red
$im->fill(50,50,$colours->{red});

MyGd::send_to_file($im);
