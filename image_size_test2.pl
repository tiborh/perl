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

use Image::Size qw(:all);

# for stream in:
{
    binmode(STDIN);
    my $img_buf;
    {
	local($/) = undef;
	$img_buf = <STDIN>;
    }
    close(STDIN);
    my ($width, $height, $id) = imgsize(\$img_buf);
    say "width: $width";
    say "height: $height";
    say "ID: $id";
}
