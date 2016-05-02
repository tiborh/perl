#!/usr/local/bin/perl -w

use Tk;
use utf8;
use encoding 'utf8';
require Tk::Font;

print "悪いウインドウ\n";
&come_window;

sub come_window {
    my $mw = MainWindow->new;
    my $bgCol = "SlateBlue1";
    my $fgCol = "White";
    $mw->configure(
	-title => "悪いウインドウ", 
	-background => $bgCol, 
	-width => "300", 
	-height => "100",
	);
    $mw->geometry("+100+300");
    my $explain_lbl = $mw->Label(
	-background => $bgCol, 
	-foreground => $fgCol,
	-text => "No option to 'pack', so vertical stack.", 
	)->pack;
    my $chkbtn1 = $mw->Checkbutton(
	-background => $bgCol, 
	-foreground => $fgCol,
	-text => "好きだ。",
	)->pack;
    my $chkbtn2 = $mw->Checkbutton(
	-background => $bgCol, 
	-foreground => $fgCol,
	-text => "嫌いです。",
	)->pack;
    my $chkbtn3 = $mw->Checkbutton(
	-background => $bgCol, 
	-foreground => $fgCol,
	-text => "知ら無。",
	)->pack;
    my $exit_btn = $mw->Button(
	-background => $bgCol,
	-foreground => $fgCol,
	-font => "Helvetica -24",
	-text => "終了", 
	-command => sub{
	    print "終了為る\n（しゅうりょう）\n";
	    exit;
	}
	)->pack;
    MainLoop;
}
