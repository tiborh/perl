#!/usr/bin/perl -w

use strict;
use Tk;
use utf8;
use encoding 'utf8';

my $kanji_font_huge = "Times -72";
my $kanji_font = "Helvetica -18";
my $normal_font = "Helvetica -12";
my $greeting = "今晩は\n（こんばんは）";
my @kanji_btn_txts = qw(日 木 本 未 末);
my $exit_btn_txt = "出";

# Main Window
my $mw = MainWindow->new;
$mw->title("漢字");

# Control Buttons
my $column_counter = 0;
foreach (@kanji_btn_txts) {
    $mw->Button(-text => $_, -command => [\&draw_kanji,$_])->grid(-row => "0", -column => $column_counter++);
}
    $mw->Button(-text => $exit_btn_txt, -command => [$mw=>'destroy'])->grid(-row => "0", -column => $column_counter);
my $kanji_lbl = $mw->Label(-text => $greeting,-font => $kanji_font)->grid(-columnspan => 6, -sticky => "nsew");

MainLoop;

sub draw_kanji {
    my $kanji_to_draw = $_[0];
#   print "$kanji_to_draw\n";
    $kanji_lbl->configure(
	-font => $kanji_font_huge,
	-text => $kanji_to_draw,
	);
}
