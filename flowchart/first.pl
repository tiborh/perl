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

# creates a box at (15,0)
my $example_box = $flowchart->box(
    "string" => "Do you need to make a flowchart?",
    "x_coord" => 15,
    "y_coord" => 0
    );

 $flowchart->draw();
