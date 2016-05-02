#!/usr/bin/perl -w

sub USAGE_NOTE {
    print "Usage:\n\t$0 <list separator>\n";
}

my @test_array = qw(one two three);
my $temp = "";

if (scalar @ARGV < 1) {USAGE_NOTE and die "Too few command line arguments.\n";}

$" = $ARGV[0];
#$temp = join($",@test_array);
#print $temp,"\n";

print "@test_array\n";
