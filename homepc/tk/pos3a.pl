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
	-title => "Positioning Study 0", 
	-background => $bgCol, 
#	-width => "300", #no use, as 'pack' manages window pars
#	-height => "100",
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
   my $頂_btn = $mw->Button(
   	-font => $kanjiFont,
   	-text => "一",
   	-command => sub{
   	    print "'top'\t（頂、いただき）\n";
   	}
   	)->pack(
   	-side => "top",
   	-expand => 0,
   	    );
    $balloon->attach($頂_btn, 
		     -balloonmsg => "top, no expand",
		     -statusmsg => "-side => \"top\", -expand => 0",
		     -balloonposition => 'mouse',
	);
   my $左_btn = $mw->Button(
   	-font => $kanjiFont,
   	-text => "二", 
   	-command => sub{
   	    print "'left'\t（左、ひだり）\n";
   	}
   	)->pack(
   	-side => "left",
   	-expand => 0,
   	    );
    $balloon->attach($左_btn, 
		     -balloonmsg => "left, no expand",
		     -statusmsg => "-side => \"left\", -expand => 0",
		     -balloonposition => 'mouse',
	);
   my $左二_btn = $mw->Button(
   	-font => $kanjiFont,
   	-text => "三", 
   	-command => sub{
   	    print "'left'\t（左、ひだり）\n";
   	}
   	)->pack(
   	-side => "left",
   	-expand => 1,
   	    );
    $balloon->attach($左二_btn, 
		     -balloonmsg => "left, expand",
		     -statusmsg => "-side => \"left\", -expand => 1",
		     -balloonposition => 'mouse',
	);
   my $右_btn = $mw->Button(
   	-font => $kanjiFont,
   	-text => "四", 
   	-command => sub{
   	    print "'right'\t（右、みぎ）\n";
   	}
   	)->pack(
   	-side => "right",
   	-expand => 0,
   	    );
    $balloon->attach($右_btn, 
		     -balloonmsg => "right, no expand",
		     -statusmsg => "-side => \"right\", -expand => 0",
		     -balloonposition => 'mouse',
	);
    my $底_btn = $mw->Button(
   	-font => $kanjiFont,
   	-text => "五（終了）", 
   	-command => sub{
   	    print "'bottom'（底、そこ,（しゅうりょう））\n";
   	    $mw->destroy;
   	}
   	)->pack(
   	-side => "bottom",
   	-expand => 0,
   	    );
    $balloon->attach($底_btn, 
		     -balloonmsg => "bottom, no expand",
		     -statusmsg => "-side => \"bottom\", -expand => 0",
		     -balloonposition => 'mouse',
	);
    MainLoop;
}
