#!/usr/bin/perl -w

use Tk;
use Tk::Balloon;
use utf8;
use encoding 'utf8';
require Tk::Font;

my $mw;
my $unpack_btn;
my $pack_btn;
my $ow_exit_btn;
my $status_bar;
my $balloon;
my $kanjiFont = "Times -48";
my $kanjiFont_small = "Helvetica -18";
&main;
MainLoop;

sub main() {
    my $bgCol = "SlateBlue1";
    my $actBgCol = "Cyan";
    my $fgCol = "White";
    my $ow;			# other window

    # Main window
    $mw = MainWindow->new;
    $mw->configure(
	-title => "Main Window", 
	-background => $bgCol, 
	);
    $mw->geometry("+100+300");
    $mw->Label(-text => 'The main window.',
	)->pack(-ipadx => '0.25i', -ipady => '0.25i');

    $unpack_btn = $mw->Button(
	-text => "Unpack Button", 
	-command => [\&hide_button], 
	-width => 20,
	)->pack;

    # Other window
    if (! Exists($ow)) {
	$ow = $mw->Toplevel;
	$ow->title('ow');
	$ow->Label(-text => 'The other window.',
	    )->pack(-ipadx => '0.25i', -ipady => '0.25i');
    }
    else {
	$ow->deiconify;
	$ow->raise;
    }

    $ow_exit_btn = $ow->Button(-text => '終了',
				  -font => $kanjiFont_small,
				  -command => [$mw => 'destroy'],
	)->pack(-side => "left", -expand => 1, -padx => 5); 
}
# -in => does not work. not yet known why. No matter whether ow wants to pack in mw or the other way around.

sub hide_button() {
    $ow_exit_btn->packForget();
    if (! Exists($pack_btn)) {
	$pack_btn = $mw->Button(
	-text => "Pack button", 
	-command => [\&show_button], 
	-width => 20,
	)->pack;
    } else {
	$pack_btn->pack;
    }
    if (Exists($unpack_btn)) {
	$unpack_btn->packForget();
    }
}

sub show_button() {
    $ow_exit_btn->pack();
    if (Exists($pack_btn)) {
	$pack_btn->packForget();
    }
    $unpack_btn->pack;
}
