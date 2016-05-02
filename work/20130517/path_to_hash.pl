#!/usr/bin/perl -w

use strict;
use Cwd;
use Time::Piece;
use File::Basename;
#use Getopt::Std;

if ($#ARGV < 0) {
    print "Give the filename as an argument.\n";
    exit(1);
}

my $infile;
my $to_read = "<";
my $from_filename = $ARGV[0];

open($infile,$to_read,$from_filename) or die "Cannot locate $from_filename, $!";
chomp (my @collect_list = <$infile>);
close($infile);

my %structure_hash = &collect_in_hash(@collect_list);

for (sort keys %structure_hash) {
    print "$_:\n";
    for (@{$structure_hash{$_}}) {
	my %temp_hash = %{$_};
	for (keys %temp_hash) {
	    print "\t$temp_hash{$_} ($_)\n";
	    print "\t$collect_list[$_]\n\n";
	}
    }
}

sub collect_in_hash() {
    my @collect_list = @_;
    my %collect_hash = ();

    $collect_hash{$_} = [ split /\//,$collect_list[$_] ] for (0 .. $#collect_list);

#   print $collect_list[0][0];
#   print "$_: @{$collect_hash{$_}}\n" for (sort {$a <=> $b} keys %collect_hash);
    my %structure_hash = ();
    my $chl2 = "";
    for (sort {$a <=> $b} keys %collect_hash) {
	#print "$_: ";
	$chl2 = (($collect_hash{$_}[-2] =~ /[Ll]egacy/) ? $collect_hash{$_}[-3] : $collect_hash{$_}[-2]);
	#print $chl2;
	#print " $collect_hash{$_}[-1]\n";
	
	push @{$structure_hash{$chl2}},{$_, $collect_hash{$_}[-1]}; 
    }
    # for (sort keys %structure_hash) {
    # 	print "$_:\n";
    # 	for (@{$structure_hash{$_}}) {
    # 	    my %temp_hash = %{$_};
    # 	    for (keys %temp_hash) {
    # 		print "\t$temp_hash{$_} ($_)\n";
    # 		print "\t@{$collect_hash{$_}}\n";
    # 		print "\t$collect_list[$_]\n\n";
    # 	    }
    # 	}
    # }
    return %structure_hash;
}

#print $collect_list[0]."\n";
#print $collect_list[-1]."\n";



