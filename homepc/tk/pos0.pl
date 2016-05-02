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
   my $いただき_btn = $mw->Button(
   	-font => $kanjiFont,
   	-text => "頂", 
   	-command => sub{
   	    print "チョウ、いただ（く）、いただき\n";
   	}
   	)->pack(
   	-side => "top",
   	-expand => 1,
   	    );
    my $そこ_btn = $mw->Button(
   	-font => $kanjiFont,
   	-text => "底", 
   	-command => sub{
   	    print "テイ、そこ\n";
   	    $mw->destroy;
   	}
   	)->pack(
   	-side => "bottom",
   	-expand => 1,
   	    );
   my $ひだり_btn = $mw->Button(
   	-font => $kanjiFont,
   	-text => "左", 
   	-command => sub{
   	    print "サ、シャ、ひだり\n";
   	}
   	)->pack(
   	-side => "left",
   	-expand => 1,
   	    );
   my $みぎ_btn = $mw->Button(
   	-font => $kanjiFont,
   	-text => "右", 
   	-command => sub{
   	    print "ウ、ユウ、みぎ\n";
   	}
   	)->pack(
   	-side => "right",
   	-expand => 1,
   	    );
    MainLoop;
}
