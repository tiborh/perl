#!/usr/bin/env perl

use warnings;
use 5.014; 			# implies strict
use Carp;
use utf8;
use autodie;
use Text::Flowchart;
#the following two needs installation:
#use Modern::Perl;
#use Test::More;

# initialisation:
my $flowchart = Text::Flowchart->new(
    "width" =>      120,
    "debug" =>      1		# good to show the frames
    );

#creates a box at (0,0), with new x_pad and y_pad values
my $example_box2 = $flowchart->box(
        "string"  => "Do you need to make a flowchart?",
        "x_coord" => 0,
        "y_coord" => 0,
        "x_pad"   => 0,
        "y_pad"   => 3
 );

 $flowchart->draw();
