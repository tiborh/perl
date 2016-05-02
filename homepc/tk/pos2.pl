#!/usr/local/bin/perl -w

use Tk;
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
    my $底_btn = $mw->Button(
   	-font => $kanjiFont,
   	-text => "二（終了）", 
   	-command => sub{
   	    print "'bottom'（底、そこ,（しゅうりょう））\n";
   	    $mw->destroy;
   	}
   	)->pack(
   	-side => "bottom",
   	-expand => 0,
   	    );
   my $左_btn = $mw->Button(
   	-font => $kanjiFont,
   	-text => "三", 
   	-command => sub{
   	    print "'left'\t（左、ひだり）\n";
   	}
   	)->pack(
   	-side => "left",
   	-expand => 0,
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
   my $左2_btn = $mw->Button(
   	-font => $kanjiFont,
   	-text => "五", 
   	-command => sub{
   	    print "'left'\t（左、ひだり）\n";
   	}
   	)->pack(
   	-side => "left",
   	-expand => 1,
   	    );
    MainLoop;
}
