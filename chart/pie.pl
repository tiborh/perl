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
my $g = Chart::Pie->new();
$g->add_dataset('Har', 'Sug', 'Ert', 'Her', 'Tar', 'Kure');
$g->add_dataset(12000, 20000 , 13000, 15000, 9000, 11000  );
my %opt = ('title'        => 'Another Pie Demo Chart',
	   'label_values' => 'both',
	   'legend'       => 'none',
	   'text_space'   => 10,
	   'png_border'   => 1,
	   'graph_border' => 0,
	   'colors' => { 'x_label'    => 'red',
		      'misc'       => 'plum',
		      'background' => 'grey',
		      'dataset0'   => 'red',
		      'dataset1'   => 'blue',
		      'dataset2'   => 'HotPink',
		      'dataset3'   => 'green',
		      'dataset4'   => 'yellow',
		      'dataset5'   => 'PaleGreen4',
	   },
	   'ring'         => 0.5,
	   'x_label'      => 'The Winner is Team Blue!',
    );
$g->set(%opt);

use File::Basename;

my $bn = (split /\./,basename($0))[0];
$g->png("$bn.png");
