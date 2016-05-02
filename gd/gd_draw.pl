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

# Create a new image
my $gd = GD::Image->new(400,300);

# Allocate colors
my $white = $gd->colorAllocate(255, 255, 255);
my $black = $gd->colorAllocate( 0, 0, 0);
my $red = $gd->colorAllocate(255, 0, 0);
my $green = $gd->colorAllocate( 0, 255, 0);
my $blue = $gd->colorAllocate( 0, 0, 255);
my $yellow = $gd->colorAllocate(255, 255, 0);

# a blue rectangle
$gd->filledRectangle(0, 129, 199, 169, $blue);

# Create a polygon, and draw two copies
my $poly = GD::Polygon->new();
$poly->addPt(199, 149);
$poly->addPt(399, 74);
$poly->addPt(324, 149);
$poly->addPt(399, 224);
$gd->filledPolygon($poly, $yellow);
$gd->polygon ($poly, $black);	# only a frame

# Create a circle, cut out an ellipse, and fill
$gd->arc(199, 149, 250, 250, 0, 360, $red);
$gd->arc(199, 149, 100, 200, 0, 360, $red);
$gd->fillToBorder(99, 149, $red, $green);

# Frame with a red border, and draw a red cross
$gd->rectangle(0, 0, 399, 299, $red);
$gd->line(199, 0, 199, 299, $red);
$gd->line(0, 149, 399, 149, $red);

# option a: send to standard out
#binmode STDOUT;
#print $gd->png;

# option b: send to file
use File::Basename;
my $bn = (split /\./,basename($0))[0];

local *IMG;
open(IMG, ">$bn.png");
binmode IMG;
print IMG $gd->png;
close IMG;
