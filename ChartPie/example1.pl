#!/usr/bin/env perl

use warnings;
use v5.14; 			# implies strict
use Carp;
use utf8;
use autodie;
#the following two needs installation:
#use Modern::Perl;
#use Test::More;

use File::Basename;
my $bn = (split /\./,basename($0))[0];

binmode(STDOUT, ":utf8");

use Chart::Pie;

my $chart = Chart::Pie->new(640,480);

$chart->set( 'title'   => 'A Day in the Life',
	     'x_label' => 'X Axis Label',
	     'y_label' => 'Y Axis Label' ,
	     'label_values' => 'value', # tell me percentage of
	     # each day spent on
	     # each activity
	     # 'x_ticks'  => 'none',
	     # 'y_ticks'  => 'none',
	     # 'x_ticks'  => 6,
	     # 'y_ticks'  => 6,
    );

$chart->add_dataset( "Mon" );
$chart->add_dataset( qw(8) );
$chart->add_dataset( qw(8) );
$chart->add_dataset( qw(2) );
$chart->add_dataset( qw(6) );

$chart->set('legend_labels' => [ 'Sleep', 'Work', 'Eat', 'Watch TV' ]);
$chart->png($bn.'.png');
