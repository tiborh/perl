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

use Chart::Pie;

my $obj = Chart::Pie->new;
$obj = Chart::Pie->new ( $gif_width, $gif_height );

$obj->set ( $key_1, $val_1, ... ,$key_n, $val_n );
$obj->set ( $key_1 => $val_1,
	    ...
	    $key_n => $val_n );
$obj->set ( %hash );

# GIFgraph.pm-style API
my @data = ( \@x_tick_labels, \@dataset1, ... , \@dataset_n );
$obj->gif ( "filename", \@data );
$obj->gif ( $filehandle, \@data );
$obj->gif ( FILEHANDLE, \@data );
$obj->cgi_gif ( \@data );

# Graph.pm-style API
$obj->add_pt ($label, $val_1, ... , $val_n);
$obj->add_dataset ($val_1, ... , $val_n);
$obj->gif ( "filename" );
$obj->gif ( $filehandle );
$obj->gif ( FILEHANDLE );
$obj->cgi_gif ();

