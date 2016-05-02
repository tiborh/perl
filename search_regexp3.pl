#!/usr/bin/perl

sub USE_SEARCH {
    print "Usage:\n\t$0 <file_to_search_in> <what_to_search_for>\n";
}

#checks:
if (scalar @ARGV < 2) {USE_SEARCH and die "Too few command line arguments.\n";}
-e $ARGV[0] or die "'$ARGV[0]' does not exist.\n";
-T $ARGV[0] or die "'$ARGV[0]' is not a text file.\n";

my $if_found = 0;
my $sought_txt = "";

#look into the file:
open(TEXT,$ARGV[0]) or die "Cannot open '$ARGV[0]': $!";
while (<TEXT>) {
    $sought_txt = lc $ARGV[1];
    if (lc($_) =~ /$sought_txt/) {
	print $_; 
	$if_found = 1;
    }
    if ($ARGV[2] =~ /debug/) {
	print $sought_txt, "\n";
	print lc $_;
    }
}

if (!$if_found) { print qq/"$ARGV[1]" has not been found in $ARGV[0].\n/ };
