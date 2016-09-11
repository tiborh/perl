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

use CD::Music;

my $bm = CD::Music->new();
print_all($bm);
my $sample = CD::Music->new("Sample",
			    "The Samplers",
			    "Sample House",
			    "0123456789",
			    12,
			    "101",
			    "01",
			    "1.1");
print_all($sample);

sub print_all {
    my $aMuCD = shift;
    say "name: ",$aMuCD->name;
    say "artist: ",$aMuCD->artist;
    say "publisher: ",$aMuCD->publisher;
    say "ISBN: ",$aMuCD->ISBN;
    say "tracks: ",$aMuCD->tracks;
    my ($room,$shelf) = $aMuCD->location;
    say "location:";
    say "\troom: $room";
    say "\tshelf: $shelf";
    say "rating: ",$aMuCD->rating || "not rated";
}
