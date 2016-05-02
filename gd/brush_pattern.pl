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

# Create a brush at an angle
my $diagonal_brush = new GD::Image(5,5);
my $white = $diagonal_brush->colorAllocate(255,255,255);
my $black = $diagonal_brush->colorAllocate(0,0,0);
$diagonal_brush->transparent($white);
$diagonal_brush->line(0,4,4,0,$black); # NE diagonal

my $myImage = new GD::Image(100,100);

# Set the brush
$myImage->setBrush($diagonal_brush);
        
# Draw a circle using the brush
$myImage->arc(50,50,25,25,0,360,gdBrushed);

MyGd::send_to_file($myImage);
