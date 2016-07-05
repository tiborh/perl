#!/usr/bin/env perl

use warnings;
use v5.14; 			# implies strict
use Carp;
use utf8;
use autodie;
#the following two needs installation:
#use Modern::Perl;
#use Test::More;
use Time::Piece;

use GD;
use GD::Graph::bars3d;
use GD::Text::Wrap;
use strict;
my @data = ( 
	["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"],
	[ 1203,  3500,  3973,  2859,  3012,  3423,  1230]
);
my $graph = GD::Graph::bars3d->new( 400, 300 );
$graph->set( 
	x_label           => 'Day of the week',
        y_label           => 'Number of hits',
        title             => 'Daily Summary of Web Site',
);

my $gd = $graph->plot( \@data );

my $img_tmp="img_tmp.png";
open FILE, ">$img_tmp";
binmode FILE;
print FILE $gd->png;
close FILE;

my $gd_image = GD::Image->newFromPng($img_tmp) ;

my $text = <<EOSTR;
Lorem ipsum dolor sit amet, consectetuer adipiscing elit,
sed diam nonummy nibh euismod tincidunt ut laoreet dolore
magna aliquam erat volutpat.
EOSTR

my $wrapbox = GD::Text::Wrap->new( $gd_image,
        line_space  => 4,
        color       => 'black',
        text        => $text,
);

$wrapbox->set(align => 'left', width => 120);
$wrapbox->draw(110,140);

open FILE, ">img.png";
binmode FILE;
print FILE $gd_image->png;
close FILE;
