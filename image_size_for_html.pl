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

my ($img_file) = 'traffic.gif';

use Image::Size qw(html_imgsize);
my $html_width_height = html_imgsize($img_file);
print qq(<img src="$img_file" $html_width_height> \n);

