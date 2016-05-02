#!/usr/bin/env perl

use warnings;
use strict;
#use Modern::Perl;
use Carp;
use utf8;
use encoding 'utf8';

my %users;

$users{Brad}{id} = 228;
$users{Jack}{id} = 229;

print "The following hash structure was created:\n";
print "$_ => $users{$_}\n" foreach (keys %users);

print "That is:\n";
foreach (keys %users) {
    print "$_ =>\n";
    my $user = $_;
    print "\t$_ => $users{$user}{$_}\n" foreach (keys %{$users{$_}});
}
