#!/usr/local/bin/perl -w

use Tk;
use utf8;
use encoding 'utf8';
require Tk::Font;

my $好き = 0;
my $嫌い = 0;
my $知ら無 = 0;

print "良いウインドウ\n";

&come_window;

if ($好き) {
    print "好きです。\n";
} else {
    print "好きじゃない。\n";
}
if ($嫌い) {
    print "嫌いです。\n";
} else {
    print "嫌じゃない。\n";
}
if ($知ら無) {
    print "知ら無。 （しらない）\n";
} else {
    print "重要です。（じゅうよう）\n";
}


sub come_window {
    my $mw = MainWindow->new;
    my $bgCol = "SlateBlue1";
    my $actBgCol = "Cyan";
    my $fgCol = "White";
    my $kanjiFont = "Helvetica -18";
    $mw->configure(
	-title => "良いウインドウ", 
	-background => $bgCol, 
	-width => "300", 
	-height => "100",
	);
    $mw->geometry("+100+300");
    my $explain_lbl = $mw->Label(
	-background => $bgCol, 
	-foreground => $fgCol,
	-text => "With options to 'pack'.", 
	)->pack;
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
	-side => "bottom",
	-expand => 1,
	-fill => "x",
	-padx => 5,
	-pady => 5,
	    );
    my $chkbtn1 = $mw->Checkbutton(
	-background => $bgCol,
	-activebackground => $actBgCol,
	-foreground => $fgCol,
	-font => $kanjiFont,
	-text => "好きだ。",
	-variable => \$好き,
	)->pack(
	-side => "left",
	-expand => 1,
	);
    my $chkbtn2 = $mw->Checkbutton(
	-background => $bgCol,
	-activebackground => $actBgCol,
	-foreground => $fgCol,
	-font => $kanjiFont,
	-text => "嫌いです。",
	-variable => \$嫌い,
	)->pack(
	-side => "left",
	-expand => 1,
	);
    my $chkbtn3 = $mw->Checkbutton(
	-background => $bgCol,
	-activebackground => $actBgCol,
	-foreground => $fgCol,
	-font => $kanjiFont,
	-text => "知ら無。",
	-variable => \$知ら無,
	)->pack(
	-side => "left",
	-expand => 1,
	);
    MainLoop;
}
