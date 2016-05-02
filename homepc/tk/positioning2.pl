#!/usr/bin/perl -w

use Tk;
use Tk::Balloon;
use utf8;
use encoding 'utf8';
require Tk::Font;

&come_window;

sub come_window {
    my $mw = MainWindow->new;
    my $bgCol = "SlateBlue1";
    my $actBgCol = "Cyan";
    my $fgCol = "White";
    my $kanjiFont = "Helvetica -18";

    $mw->configure(
	-title => "Positioning", 
	-background => $bgCol, 
	#-width => "300", 
	#-height => "100",
	);
    $mw->geometry("+100+300");
    my $status_bar = $mw->Label(
	-borderwidth => 2, 
	-relief => 'groove',
	-width => 35,
	)->pack(-side => 'bottom', -fill => 'x');
    my $balloon = $mw->Balloon(
	-statusbar => $status_bar
	);
    my $north_btn = $mw->Button(
	-text => "北", 
	-width => 10,
	-font => $kanjiFont,
	-command => sub{
	    print "北 （きた）\n"; 
	}
	)->pack(-side => "top", -expand => 1, -fill=>"both");
    $balloon->attach($north_btn, 
		     -balloonmsg => "きた",
		     -statusmsg => "-side=>\"top\", -expand=>1, -fill=>\"both\"",
		     -balloonposition => 'mouse',
	);
    my $south_btn = $mw->Button(
	-text => "南", 
	-width => 10,
	-font => $kanjiFont,
	-command => sub{
	    print "南 （みなみ）\n"; 
	}
	)->pack(-side => "bottom", -expand => 1, -fill => "y");
    $balloon->attach($south_btn, 
		     -balloonmsg => "みなみ",
		     -statusmsg => "-side => \"bottom\",-expand =>1, -fill=>\"y\"",
		     -balloonposition => 'mouse',
	);
    my $west_btn = $mw->Button(
	-text => "西", 
	-width => 10,
	-font => $kanjiFont,
	-command => sub{
	    print "西 （にし）\n"; 
	}
	)->pack(-side => "left", -expand => 0, -before => $north_btn);
    $balloon->attach($west_btn, 
		     -balloonmsg => "にし",
		     -statusmsg => "-side => \"left\", -expand => 0",
		     -balloonposition => 'mouse',
	);
    my $exit_btn = $mw->Button(
	-background => $bgCol,
	-activebackground => $actBgCol,
	-foreground => $fgCol,
	-font => $kanjiFont,
	-text => "終了", 
	-command => sub{
	    print "終了為る（しゅうりょうする）\n";
	    $mw->destroy;
	}
	)->pack(
	-side => "left",
	-expand => "1",
	    );
    $balloon->attach($exit_btn, 
		     -balloonmsg => "しゅうりょう",
		     -statusmsg => "-side => \"left\", -expand => 1",
		     -balloonposition => 'mouse',
	);
    my $east_btn = $mw->Button(
	-text => "東", 
	-width => 10,
	-font => $kanjiFont,
	-command => sub{
	    print "東 （ひがし）\n"; 
	}
	)->pack(-side => "right", -expand => 1, -fill => "x", -before => $north_btn);
    $balloon->attach($east_btn, 
		     -balloonmsg => "ひがし",
		     -statusmsg => "-side=>\"right\", -expand=>1, -fill=>\"x\"",
		     -balloonposition => 'mouse',
	);
    MainLoop;
}
