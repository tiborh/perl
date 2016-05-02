#!/usr/bin/perl -w

use strict;
use utf8;
use Tk;

my $mw = MainWindow->new;
$mw->title("Font Families");
$mw->minsize(qw(400 250));

my @mw_data = $mw->configure();

print "@{$_}\n" foreach (@mw_data);

#print "$_: ${$mw}{$_}\n" foreach (%{$mw});
