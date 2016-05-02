#!/usr/bin/perl -w

use strict;
use Tk;
use utf8;
use encoding 'utf8';

my $kanji_font_huge = "Times -72";
my $kanji_font = "Helvetica -18";
my $normal_font = "Helvetica -12";
my $greeting = "今晩は\n（こんばんは）";
my %kanji_data = (
    日 => {
	音 => [qw(ニチ ジツ)],
	訓 => [qw(ひ ーび ーか)],
    },
    木 => {
	音 => [qw(ボク モク)],
	訓 => [qw(き ーこ)],
    },
    本 => {
	音 => [qw(ホン)],
	訓 => [qw(もと)],
    },
    未 => {
	音 => [qw(ミ)],
	訓 => [qw(ま·だ)],
    },
    末 => {
	音 => [qw(マツ バツ)],
	訓 => [qw(すえ)],
    },
    零 => {
	音 => [qw(レイ)],
	訓 => [qw(ぜろ こぼ·す こぼ·れる)],
    },
    );
my %button_txt = (
    b_prev => "前",
    b_next => "次",
    b_on => "音",
    b_kun => "訓",
    b_example => "例",
    b_kanji => "漢",
    b_exit => "出",
    );


# Main Window
my $mw = MainWindow->new;
$mw->title("漢字");
$mw->minsize(qw(275 150));

# Frames
my $body_frm = $mw->Frame(-background=>'blue')->pack(-side => 'top', -fill => 'both', -expand => 1);
 my $control_frm = $body_frm->Frame(-background=>'black')->pack(-side => 'left', -fill => 'both', -expand => 1);
  my $logo_frm = $control_frm->Frame(-background=>'white')->pack(-side => 'top', -fill => 'both', -expand => 1);
  my $display_control_frm = $control_frm->Frame(-background=>'white')->pack(-side => 'top', -fill => 'both', -expand => 1);
  my $program_control_frm = $control_frm->Frame(-background=>'white')->pack(-side => 'top', -fill => 'both', -expand => 1);
 my $button_frm = $body_frm->Frame(-background=>'yellow')->pack(-side => 'top', -fill => 'both', -expand => 1);
 my $study_frm = $body_frm->Frame(-background=>'brown')->pack(-side => 'top', -fill => 'both', -expand => 1);
  my $kanji_frm = $study_frm->Frame(-background=>'red')->pack(-side => 'left', -fill => 'both', -expand => 1);
  my $example_frm = $study_frm->Frame(-background=>'green')->pack(-side => 'left', -fill => 'both', -expand => 1);

# Kanji Buttons
my %kanji_btns;
my $kanji_var = "零";
foreach (sort keys %kanji_data) {
    $kanji_btns{$_} = $button_frm->Radiobutton(
	-text => $_,
	-font => $kanji_font,
	-variable => \$kanji_var, 
	-value => $_, 
	-indicatoron => 0,
	-relief => 'flat',
	-command => [\&draw_kanji,\$_],
	-width => 3,
	)->pack(-fill => 'both', -expand => 1, -side => 'left', -anchor => 'n');
}

# Control Buttons
# my $prev_btn = $control_frm->Button(
#     -text => $button_txt{'b_prev'}, 
#     -font => $kanji_font,
#     )->pack(-fill => 'both', -expand => 1, -side => 'left');
# my $next_btn = $control_frm->Button(
#     -text => $button_txt{'b_next'}, 
#     -font => $kanji_font,
#     )->pack(-fill => 'both', -expand => 1, -side => 'left');
# my $example_btn = $control_frm->Button(
#     -text => $button_txt{'b_example'}, 
#     -font => $kanji_font,
#     )->pack(-fill => 'both', -expand => 1, -side => 'left');

my $display_select = $button_txt{'b_kanji'};
my $kanji_logo = $logo_frm->Label(-text => "漢字",-font => $kanji_font)->pack(-fill => 'both', -expand => 1);
my $kanji_btn = $display_control_frm->Radiobutton(
    -text => $button_txt{'b_kanji'},
    -font => $kanji_font,
    -variable => \$display_select, 
    -value => $button_txt{'b_kanji'}, 
    -indicatoron => 0,
    -relief => 'flat',
    -command => [\&draw_kanji,\$kanji_var],
    )->pack(-fill => 'both', -expand => 1, -side => 'top');
my $on_btn = $display_control_frm->Radiobutton(
    -text => $button_txt{'b_on'},
    -font => $kanji_font,
    -variable => \$display_select, 
    -value => $button_txt{'b_on'}, 
    -indicatoron => 0,
    -relief => 'flat',
    -command => [\&print_kana,\$kanji_var,\$display_select,\%kanji_data],
    )->pack(-fill => 'both', -expand => 1, -side => 'top');
my $kun_btn = $display_control_frm->Radiobutton(
    -text => $button_txt{'b_kun'},
    -font => $kanji_font,
    -variable => \$display_select, 
    -value => $button_txt{'b_kun'}, 
    -indicatoron => 0,
    -relief => 'flat',
    -command => [\&print_kana,\$kanji_var,\$display_select,\%kanji_data],
    )->pack(-fill => 'both', -expand => 1, -side => 'top');
my $exit_btn = $program_control_frm->Button(
    -text => $button_txt{'b_exit'}, 
    -font => $kanji_font,
    -command => [$mw=>'destroy'],
    )->pack(-fill => 'both', -expand => 1, -side => 'top');

# Study Field
my $kanji_lbl = $kanji_frm->Label(-text => $kanji_var,-font => $kanji_font_huge)->pack(-fill => 'both', -expand => 1);
my $example_lbl = $example_frm->Label(
    -text => $button_txt{'b_example'},
    -font => $kanji_font,
    )->pack(-anchor => 'nw');

MainLoop;

sub draw_kanji {
    my $kanji_to_draw = $_[0] ? ${$_[0]} : "零";
    $kanji_lbl->configure(
	-font => $kanji_font_huge,
	-text => $kanji_to_draw,
	);
    $display_select = $button_txt{'b_kanji'};
}

sub print_kana {
    my $kanji_var = ${$_[0]};
    my $display_select = ${$_[1]};
    my %kanji_data = %{$_[2]};
    my @input = @{$kanji_data{$kanji_var}{$display_select}};
    my $kana_to_print = "";
    foreach (@input) {
    	$kana_to_print .= $_;
	$kana_to_print .= "\n";
    }
    substr($kana_to_print,-1,1,"");
    $kanji_lbl->configure(
    	-font => $kanji_font,
    	-text => $kana_to_print,
    	);
}

