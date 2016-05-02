#!/usr/bin/perl -w

use Tk;
use Tk::Balloon;
use utf8;
use encoding 'utf8';
require Tk::Font;

my $mw;
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
    my $ww;			# warning window

    # Main window
    $mw = MainWindow->new;
    $mw->configure(
	-title => "Unit test", 
	-background => $bgCol, 
	);
    $mw->geometry("+100+300");

    # Status bar
    $status_bar = $mw->Label(
	-borderwidth => 2, 
	-relief => 'groove',
	-width => 35,
	)->pack(-side => 'bottom', -fill => 'x');

    # Balloon: for statusbar msg's but also for tooltips
    $balloon = $mw->Balloon(
	-statusbar => $status_bar
	);

    # Label
    my $sample_lbl = $mw->Label(
	-text => "今日は！", 
	-height => 3,		# units are not accepted here
	-width => 10,
	-font => $kanjiFont,
	)->pack(-padx => "1i"); # units are accepted here
    $balloon->attach($sample_lbl, 
		     -balloonmsg => "Hello, there!",
		     -statusmsg => "Label: -height=>3,-width=>10; Pack: -padx=>\"1i\"",
		     -balloonposition => 'mouse',
	);
    my $exit_btn = $mw->Button(-text => 'Exit',
                       -command => \&send_warning);
    $balloon->attach($exit_btn,
		     -balloonmsg => "終了爲る",
		     -statusmsg => "しゅうりょうする",
		     -balloonposition => 'mouse',
	);
    $exit_btn->pack(-pady => "0.25i");
}

#Warning Window
sub send_warning() {
    if (! Exists($ww)) {
	$ww = $mw->Toplevel;
	$ww->title('Confirmation');
	$ww->Label(-text => 'Do you want to exit?',
	    )->pack(-ipadx => '0.25i', -ipady => '0.25i');
	my $ww_exit_btn = $ww->Button(-text => '終了',
				      -font => $kanjiFont_small,
				      -command => [$mw => 'destroy'],
	    )->pack(-side => "left", -expand => 1, -padx => 5);
	$balloon->attach($ww_exit_btn,
			 -balloonmsg => "終了爲る",
			 -statusmsg => "Exit the program",
			 -balloonposition => 'mouse',
	    );
	my $ww_cancel_btn = $ww->Button(-text => 'キャンセル',
					-font => $kanjiFont_small,
					-command => sub {$ww->withdraw }
	    )->pack(-side => "left", -expand => 1, -padx => 5);
	$balloon->attach($ww_cancel_btn,
			 -balloonmsg => "きゃんせる",
			 -statusmsg => "Cancel",
			 -balloonposition => 'mouse',
	    );
    }
    else {
	$ww->deiconify;
	$ww->raise;
    }
}
