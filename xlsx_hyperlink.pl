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

use Excel::Writer::XLSX;

my $workbook = Excel::Writer::XLSX->new("spread_with_link.xlsx");
my $worksheet = $workbook->add_worksheet("hyper");
$worksheet->write(0,0, 'Hello');
$worksheet->write(1,0, 'http://harcsa.net','my site');
$workbook->close();
