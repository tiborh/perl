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
$mw->minsize(qw(250 100));

# Frames
my $body_frm = $mw->Frame(-background=>'blue')->pack(-side => 'top', -fill => 'both', -expand => 1);
my $button_frm = $body_frm->Frame(-background=>'yellow')->pack(-side => 'top', -fill => 'both', -expand => 1);
my $kanji_frm = $body_frm->Frame(-background=>'red')->pack(-side => 'top', -fill => 'both', -expand => 1);
my $control_frm = $body_frm->Frame(-background=>'black')->pack(-side => 'top', -fill => 'both', -expand => 1);

# Kanji Buttons
my %kanji_btns;
my $kanji_var;
foreach (@kanji_btn_txts) {
    $kanji_btns{$_} = $button_frm->Radiobutton(
	-text => $_,
	-font => $kanji_font,
	-variable => \$kanji_var, 
	-value => $_, 
	-indicatoron => 0,
	-relief => 'flat',
	-command => [\&draw_kanji,$_],
	)->pack(-fill => 'both', -expand => 1, -side => 'left');
}

# Control Buttons
my $exit_btn = $control_frm->Button(
    -text => $exit_btn_txt, 
    -font => $kanji_font,
    -command => [$mw=>'destroy'],
    )->pack(-fill => 'both', -expand => 1, -side => 'left');

# Kanji Label
my $kanji_lbl = $kanji_frm->Label(-text => $greeting,-font => $kanji_font)->pack(-fill => 'both', -expand => 1);

MainLoop;

sub draw_kanji {
    my $kanji_to_draw = $_[0];
#   print "$kanji_to_draw\n";
    $kanji_lbl->configure(
	-font => $kanji_font_huge,
	-text => $kanji_to_draw,
	);
}

