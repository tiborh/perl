#!/usr/bin/perl -w

use strict;

my $lat_path = "~/lat";
my @story_files = ();

&dir_crawler($lat_path);
print "$_\n" for @story_files;

sub dir_crawler() {
    my @dir = <$_[0]/*>;
    for (@dir) {
	push(@story_files,$_) if /.*\.story$/;
	&dir_crawler($_) if -d;
    }
}
