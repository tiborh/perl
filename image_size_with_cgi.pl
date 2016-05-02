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

use CGI qw(:standard);
use Image::Size qw(attr_imgsize);
#my @width_height_attributes = attr_imgsize($img_file);
#print img {src => $img_file, @width_height_attributes};
say img {src => $img_file, attr_imgsize($img_file)};

