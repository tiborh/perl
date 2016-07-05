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

use TimeStamp;

my $fh;
my $fn = "test_".TS::ts().".txt";
my $fm = ">";
open($fh,$fm,$fn) or croak "Cannot open file for writing $fn.";
print $fh $fn,"\n";
close $fh;
my @filestat = stat($fn);
my $mtime = $filestat[9];
say "filename: $fn";
use POSIX 'strftime';
say "file mtime: ",strftime('%c',localtime($mtime));
unlink($fn);
