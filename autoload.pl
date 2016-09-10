#!/usr/bin/env perl

use warnings;
use v5.14; 			# implies strict
use Carp;
use utf8;
use autodie;
#the following two needs installation:
#use Modern::Perl;
#use Test::More;

binmode(STDOUT, ":utf8");

sub AUTOLOAD {
    our $AUTOLOAD =~ s/.*:://;# Strip leading package name
    return `$AUTOLOAD @_`;# Execute in a shell
}

# and later…
my $files = dir();
del('DATA.TMP');
my $help = type("HELP.TXT");
say "but the script is still alive";
