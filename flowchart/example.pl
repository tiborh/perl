#!/usr/bin/env perl

use warnings;
use 5.014; 			# implies strict
use Carp;
use utf8;
binmode STDOUT, 'encoding(UTF-8)';
use autodie;
#the following two needs installation:
#use Modern::Perl;
#use Test::More;
use Text::Flowchart;

my $flowchart = Text::Flowchart->new(
    "width" => 50,
    "directed" => 0);

my $begin = $flowchart->box(
    "string" => "BEGIN",
    "x_coord" => 0,
    "y_coord" => 0,
    "width"   => 9,
    "y_pad"   => 0
    );

my $start = $flowchart->box(
    "string" => "Do you need to make a flowchart?",
    "x_coord" => 15,
    "y_coord" => 0
    );

my $yes = $flowchart->box(
    "string" => "Then my module may help.",
    "x_coord" => 0,
    "y_coord" => 10
    );

my $use = $flowchart->box(
    "string" => "So use it.",
    "x_coord" => 16,
    "y_coord" => 8,
    "width"   => 14
    );

my $no = $flowchart->box(
    "string" => "Then go do something else.",
    "x_coord" => 30,
    "y_coord" => 17
    );

$flowchart->relate(
    [$begin, "right"] => [$start, "left", 1]
    );

$flowchart->relate(
    [$start, "left", 3] => [$yes, "top", 5],
    "reason" => "Y"
    );

$flowchart->relate(
    [$start, "right", 2] => [$no, "top", 5],
    "reason" => "N"
    );

$flowchart->relate(
    [$yes, "right", 4] => [$use, "bottom", 2]
    );

$flowchart->relate(
    [$use, "bottom", 6] => [$no, "left", 2]
    );

$flowchart->draw();

print "It works！\n";
print "始めまして。\n";
