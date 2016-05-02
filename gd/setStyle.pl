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

my $myImage = new GD::Image(100,100);

# Set a style consisting of 4 pixels of yellow,
# 4 pixels of blue, and a 2 pixel gap
my $colours = MyGd::define_colours($myImage);

$myImage->setStyle($colours->{yellow},$colours->{yellow},$colours->{yellow},$colours->{yellow},
		   $colours->{blue},$colours->{blue},$colours->{blue},$colours->{blue},
		   gdTransparent,gdTransparent);
$myImage->arc(50,50,25,25,0,360,gdStyled);

MyGd::send_to_file($myImage);
