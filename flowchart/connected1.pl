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
    "width" =>      50,
    "directed" =>   1,
    "debug" =>      1		# good to show the frames
    );

#creates a box at (0,0)
my $example_box = $flowchart->box(
    "string" => "Do you need to make a flowchart?",
    "x_coord" => 0,
    "y_coord" => 2,
    );
 
#creates a box at (15,0)
my $example_box2 = $flowchart->box(
    "string" => "Yes I do.",
    "x_coord" => 19,
    "y_coord" => 0,
    "width"   => 13
    );
 
#creates a box at (15,0)
my $example_box3 = $flowchart->box(
    "string" => "No I don't.",
    "x_coord" => 19,
    "y_coord" => 7
    );
 
$flowchart->relate(
    [$example_box, "right"] => [$example_box2, "left"],
    "reason" => "Y"
 );
 
$flowchart->relate(
    [$example_box, "right", -1] => [$example_box3, "left"],
        "reason" => "N"
 );
 
$flowchart->draw();
