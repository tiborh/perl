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

say "dummy. template.";

sub chart_draw {
    use Chart::Points;   #(type is one of: Points, Lines, Bars, LinesPoints, Composite,
		       # StackedBars, Mountain, Pie, HorizontalBars, Split, ErrorBars, Pareto, Direction) 

    my $png_width = 300;
    my $png_height = 200;
    my $obj = Chart::Points->new;
    # $obj = Chart::Points->new ( $png_width, $png_height );
    
    # $obj->set ( $key_1, $val_1, ... ,$key_n, $val_n );
    # $obj->set ( $key_1 => $val_1,
    # 		...
    # 		$key_n => $val_n );
    my %hash = (
	one => 1,
	two => 2,
	three => 3,
	);
    $obj->set ( %hash );
 
    # GIFgraph.pm-style API to produce png formatted charts
    my @data = ( \@x_tick_labels, \@dataset1, ... , \@dataset_n );
    $obj->png ( "filename", \@data );
    $obj->png ( $filehandle, \@data );
    $obj->png ( FILEHANDLE, \@data );
    $obj->cgi_png ( \@data );
    
    # Graph.pm-style API
    $obj->add_pt ($label, $val_1, ... , $val_n);
    $obj->add_dataset ($val_1, ... , $val_n);
    $obj->png ( "filename" );
    $obj->png ( $filehandle );
    $obj->png ( FILEHANDLE );
    $obj->cgi_png ();
 
    #The similar functions are available for j-peg
	
    # Retrieve image map information
    $obj->set ( 'imagemap' => 'true' );
    $imagemap_ref = $obj->imagemap_dump ();
}
