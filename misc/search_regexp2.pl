#!/usr/bin/perl

sub USE_SEARCH {
    print "Usage:\n\t$0 <file_to_search_in> <what_to_search_for>\n";
}

#checks:
if (scalar @ARGV < 2) {USE_SEARCH and die "Too few command line arguments.\n";}
-T $ARGV[0] or die "'$ARGV[0]' is not a text file.\n";

#look into the file:
open(TEXT,$ARGV[0]) or die "Cannot open '$ARGV[0]': $!";

while (<TEXT>) {
    print if /$ARGV[1]/;
}
