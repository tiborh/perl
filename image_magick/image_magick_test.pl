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
my ($img_file) = 'traffic.gif';
   
# does not work:
# {
#     my ($width, $height, $size, $format) = Image::Magick->Ping($img_file)
# 	or die "Cannot get info for $img_file, $!";
# }

{
    my $im = Image::Magick->new();
    my $rc = $im->Read($img_file);
    die "Cannot read $img_file: $rc" if $rc;
    my ($width, $height, $format) = $im->Get('width', 'height', 'magick');
    say "width: $width";
    say "height: $height";
    say "format: $format";
}
