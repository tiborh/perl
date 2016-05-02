#!/usr/bin/perl -w

use strict;
use base "HTML::TokeParser";

my $html_filename = "simple.html";
my $debug = 0;
my %tag_inventory = ();

die "Give an html filename as argument." if (@ARGV < 1);
$html_filename = $ARGV[0];

&get_tags(\%tag_inventory,$html_filename);
&print_hash(\%tag_inventory);

sub get_tags {
    open(my $fh, "<:utf8", $_[1]) || die "Can't open '$_[1]': $!";
    my $p = HTML::TokeParser->new( $fh );

    $p->empty_element_tags(1);  # configure its behaviour

    while (my $token = $p->get_token) {
	${$_[0]}{$token->[1]}++ if ($token->[0] eq 'S');
    }
}

sub print_hash {
    my $hash_ref = $_[0];
    
    for (sort keys %{$hash_ref}) {
	print "$_\t=>\t${$hash_ref}{$_}\n";
    }
}
