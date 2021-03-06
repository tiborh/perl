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

use Image::Magick;
my $rc;
my $img = Image::Magick->new();
my $fn_root = "traffic";
my $fn_gif = $fn_root . '.gif';
my $fn_jpg = $fn_root . '.jpg';

#We read in a GIF format file, and save it as a jpg format file.
unlink($fn_jpg) if (-e $fn_jpg);

$rc = $img->Read($fn_gif);
warn $rc if $rc;

$rc = $img->Write($fn_jpg);
warn $rc if $rc;

say "$fn_gif -> $fn_jpg";
