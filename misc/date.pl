#!/usr/bin/perl -w

use strict;
use Time::Piece;

my $doc_date = Time::Piece->new->strftime('%Y-%m-%d');
print $doc_date,"\n";
