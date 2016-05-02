#!/usr/bin/perl -w

use strict;
use Tk;
require Tk::Balloon;
require Tk::ROText;
require Tk::NoteBook;
use utf8;
use encoding 'utf8';

use LangDat;

my %kanji_data = %LangDat::kanji_data;
my %word_data = %LangDat::word_data;
my @kanji_tab_labels = @LangDat::kanji_tab_labels;

my $kanji_font_huge = "KochiMincho -144";
my $kanji_font = "KochiMincho -24";
my $example_font = "KochiMincho -18";
my $normal_font = "KochiGothic -14";
my $stroke_order_font = "KanjiStrokeOrders -144";
my $kanji_font_small = $example_font;

my %label_txt = (
    l_prev => "前",
    l_next => "次",
    l_on => "音",
    l_kun => "訓",
    l_gi => "義",
    l_ei => "英",
    l_example => "例",
    l_kanji => "漢",
    l_exit => "出",
    );

my @display_labels = qw(l_on l_kun l_gi l_ei l_example l_kanji);

# Main Window
my $mw = MainWindow->new;
$mw->title("漢字");
$mw->minsize(qw(500 600));

# Frames
my $body_frm = $mw->Frame(-background=>'cadetblue')->pack(-side => 'top', -fill => 'both', -expand => 1);
  my $data_frm = $body_frm->Frame(-background=>'ivory')->pack(-side => 'top', -fill => 'both', -expand => 1);
  my $button_frm = $body_frm->Frame(-background=>'lavender')->pack(-side => 'bottom', -fill => 'both', -expand => 1);
  #my $display_control_frm = $control_frm->Frame(-background=>'white')->pack(-side => 'top', -fill => 'both', -expand => 1);
  #my $program_control_frm = $control_frm->Frame(-background=>'white')->pack(-side => 'top', -fill => 'both', -expand => 1);
 #my $button_frm = $body_frm->Frame(-background=>'yellow')->pack(-side => 'top', -fill => 'both', -expand => 1);

# The labels of the data items
my %kanji_labels = ();
foreach (@display_labels) {
    $kanji_labels{$_} = $data_frm->Label(
	#-anchor => 'w',
	-text => $label_txt{$_},
	-font => $kanji_font,
	#-justify => 'left',
	-relief => 'groove',)->pack( -fill => 'y', -expand => 1, -side => 'top', -anchor => 'n' );
}

MainLoop;
