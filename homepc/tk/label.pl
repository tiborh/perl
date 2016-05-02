#!/usr/local/bin/perl -w

use Tk;
use utf8;
use encoding 'utf8';
require Tk::Font;

print "今日は！\n";
&come_window;

sub come_window {
    my $mw = MainWindow->new;
    my $defCol = "SlateBlue1";
    $mw->configure(
	-title => "Geometry experiments", 
	-background => $defCol, 
	-width => "300", 
	-height => "100",
	);
    $mw->geometry("+100+300");
    my $test_lbl = $mw->Label(
	-background => $defCol, 
	-text => "今日は！", 
	-font => "Helvetica -24",
	-height => 3,
	-width => 20,
	)->pack;
    my $kanji_lbl = $mw->Label(
	-text => "開",
	-font => "Helvetica -96",
	-height => 1,
	-width => 5,
	)->pack;
    my $exit_btn = $mw->Button(
	-background => $defCol,
	-font => "Helvetica -24",
	-text => "終了", 
	-width => 10,
	-command => sub{
	    print "終了する\n"; 
	    exit;
	}
	)->pack;
    MainLoop;
}
