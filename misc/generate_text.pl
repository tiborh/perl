#!/usr/bin/perl -w

use strict;

my $mwl = 13;		# max word length minus 1
my $mnsl = 3;		# min sentence length
my $mxsl = 27;		# max sentence length minus $mnsl
my $mnpl = 3;		# min paragraph length
my $mxpl = 12;		# max paragraph length minus $mnpl

if (!@ARGV) {
    die "Give the number of paragraphs\n";
}

if ($ARGV[0] > 5000) {
    warn "This may take a little time.\n";
}

for(my $i=0; $i<$ARGV[0]; $i++) {
    print &gen_par($mwl,$mnsl,$mxsl,$mnpl,$mxpl);
}

sub gen_par {
    my $par = "  ";

    for(my $i=0; $i<int($_[3]+rand($_[4])); $i++) {
	$par .= sprintf("%s",&gen_sent($mwl,$mnsl,$mxsl));
	$par .= " ";
    }
    $par =~ s/ $/\n/;
    return $par;
}

sub gen_sent {
    my $sent = "";		# the sentence string.
    my $cap = 0;		# to make first letter capitalised
    
    for(my $i=0;$i<int($_[1]+rand($_[2]));$i++) {
	$cap = (!$i) ? 1 : 0;
	if (!$cap) { 
	    $sent .= sprintf("%c",32);
	}
	$sent .= sprintf("%s",&gen_word($_[0],$cap));
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
