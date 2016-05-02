#!/usr/bin/perl -w

use Tk;

my $mw = MainWindow->new;
$mw->title("Hello world");
$mw->Label(-text => "Hello world!", -height => 5)->pack;
$mw->Button(-text => "Done", -command => sub{exit}, -width => 20)->pack;
MainLoop;
