#!/usr/bin/perl -w

use strict;
use Tk;
use utf8;
use encoding 'utf8';

my $kanji_font_huge = "Times -72";
my $kanji_font = "Helvetica -18";
my $normal_font = "Helvetica -12";
my $greeting = "今晩は\n（こんばんは）";
my @kanji_btns = qw(日 木 本 未 末);
my $exit_btn_txt = "出";

# Main Window
my $mw = MainWindow->new;
$mw->title("漢字");

# Control Buttons
my $first_btn = $mw->Button(-text => $kanji_btns[0], -command => [\&draw_kanji,$kanji_btns[0]])->grid(
    $mw->Button(-text => $kanji_btns[1], -command => [\&draw_kanji,$kanji_btns[1]]),
    $mw->Button(-text => $kanji_btns[2], -command => [\&draw_kanji,$kanji_btns[2]]),
    $mw->Button(-text => $kanji_btns[3], -command => [\&draw_kanji,$kanji_btns[3]]),
    $mw->Button(-text => $kanji_btns[4], -command => [\&draw_kanji,$kanji_btns[4]]),
    $mw->Button(-text => $exit_btn_txt, -command => [$mw=>'destroy']));
my $kanji_lbl = $mw->Label(-text => $greeting,-font => $kanji_font)->grid(-columnspan => 6, -sticky => "nsew");

# you cannot use more than one geometry method at a time
# my $central_lbl = $mw->Label(
#     -text => $greeting,
#     -font => $kanji_font,
#     )->pack(-ipadx => 10,-ipady => 5);


MainLoop;

sub draw_kanji {
    my $kanji_to_draw = $_[0];
#   print "$kanji_to_draw\n";
    $kanji_lbl->configure(
	-font => $kanji_font_huge,
	-text => $kanji_to_draw,
	);
}
