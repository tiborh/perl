#!/usr/bin/perl -w

use Tk;
use strict;

my $tl;
my $mw = MainWindow->new;
$mw->title("MainWindow");
$mw->Button(-text => "Toplevel", -command => \&do_Toplevel)->pack( );

MainLoop;

sub do_Toplevel {
    if (! Exists($tl)) {
	$tl = $mw->Toplevel( );
	$tl->title("Toplevel");
	$tl->Button(-text => "Close", 
		    -command => sub { $tl->withdraw })->pack;
    } else {
	$tl->deiconify( );
	$tl->raise( );
    }
}
