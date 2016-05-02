#!/usr/bin/perl -w

use strict;
use utf8;
use Tk;

my $mw = MainWindow->new;
$mw->title("Font Families");
$mw->minsize(qw(400 250));

foreach (sort $mw->fontFamilies) {
    print "$_\n";
}
