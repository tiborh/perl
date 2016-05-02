#!/usr/bin/perl -w

use strict;

my @array = ();
my $strsent = "";
my %collect = ();
my $mxrs = 100000;		# maximum number of runs

for (my $i=0; $i<$mxrs; $i++) {
    $strsent = &gen_sent;
    @array = split / /, $strsent;
    $collect{scalar(@array)}++;
}

foreach my $key (sort keys %collect) {
    printf("%3d => %5d (%5.2f%%)\n",$key,$collect{$key},($collect{$key}/$mxrs)*100);
}

sub gen_sent {
    my $mwl = 13;		# max word length minus 1
    my $mnsl = 3;		# min sentence length
    my $mxsl = 27;		# max sentence length minus $mnsl
    my $sent = "";		# the sentence string.
    my $cap = 0;		# to make first letter capitalised
    
    for(my $i=0;$i<int($mnsl+rand($mxsl));$i++) {
	$cap = (!$i) ? 1 : 0;
	if (!$cap) { 
	    $sent .= sprintf("%c",32);
	}
	$sent .= sprintf("%s",&gen_word($mwl,$cap));
    }
    $sent .= sprintf("%c",46);
#   return $sent; 
}

sub gen_word {
    my $gword = sprintf("%s",&gen_chars(1+int(rand($_[0])),$_[1]));
#    return $gword;
}

sub gen_chars {
    my $gchars = "";
    my $gchar = 0;
    for (my $i = 0; $i < $_[0]; $i++) {
	$gchar = 97+int(rand(26));
	if (($_[1]) && (!$i)) {
	    $gchar -= 32;
	}
	$gchars .= sprintf("%c",$gchar);
    }
    return $gchars;
}
