#!/usr/bin/perl -w

use strict;
use base "HTML::TokeParser";
use Data::Dumper;

my $html_filename = "simple.html";

open(my $fh, "<:utf8", $html_filename) || die "Can't open '$html_filename': $!";
my $p = HTML::TokeParser->new( $fh );

$p->empty_element_tags(1);  # configure its behaviour

my $token = $p->get_token;
print Dumper($p);

# while (my $token = $p->get_token) {
#     for (@$token) {
# 	print;
#     }
# }
