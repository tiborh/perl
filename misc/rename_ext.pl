#!/usr/bin/perl -w

use strict;

my $old_ext = $ARGV[0] ? $ARGV[0] : "tar";
my $new_ext = $ARGV[1] ? $ARGV[1] : "lzma";

my @files = <*>;

foreach my $file (@files) {
    my $oldfile = $file;
    $file =~ s/(.*)$old_ext/$1$new_ext/;
    if ($oldfile ne $file) {
	print "$oldfile -> $file\n";
	rename($oldfile,$file);
    }
}

