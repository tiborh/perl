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

my $kanji_font_huge = "KochiMincho -144";
my $kanji_font = "KochiMincho -24";
my $example_font = "KochiMincho -18";
my $normal_font = "KochiGothic -14";
my $stroke_order_font = "KanjiStrokeOrders -144";
my $kanji_font_small = $example_font;

my %button_txt = (
    b_prev => "前",
    b_next => "次",
    b_on => "音",
    b_kun => "訓",
    b_gi => "義",
    b_ei => "英",
    b_example => "例",
    b_kanji => "漢",
    b_exit => "出",
    );

# Main Window
my $mw = MainWindow->new;
$mw->title("漢字");
$mw->minsize(qw(275 150));

# Other Window(s)
my $ww;				# exit_warning window

my $radical_stump = "部首（ぶしゅ） will come here.";

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
    -command => \&print_kana,
    )->pack(-fill => 'both', -expand => 1, -side => 'top');
my $kun_btn = $display_control_frm->Radiobutton(
    -text => $button_txt{'b_kun'},
    -font => $kanji_font,
    -variable => \$display_select, 
    -value => $button_txt{'b_kun'}, 
    -indicatoron => 0,
    -relief => 'flat',
    -command => \&print_kana,
    )->pack(-fill => 'both', -expand => 1, -side => 'top');
my $gi_btn = $display_control_frm->Radiobutton(
    -text => $button_txt{'b_gi'},
    -font => $kanji_font,
    -variable => \$display_select, 
    -value => $button_txt{'b_gi'}, 
    -indicatoron => 0,
    -relief => 'flat',
    -command => \&print_kana,
    )->pack(-fill => 'both', -expand => 1, -side => 'top');
my $英_btn = $display_control_frm->Radiobutton(
    -text => $button_txt{'b_ei'},
    -font => $kanji_font,
    -variable => \$display_select, 
    -value => $button_txt{'b_ei'}, 
    -indicatoron => 0,
    -relief => 'flat',
    -command => \&print_english,
    )->pack(-fill => 'both', -expand => 1, -side => 'top');
my $exit_btn = $program_control_frm->Button(
    -text => $button_txt{'b_exit'}, 
    -font => $kanji_font,
    -command => \&exit_warning,
    )->pack(-fill => 'both', -expand => 1, -side => 'top');

# Study Field
my $kanji_lbl = $kanji_frm->Label(-text => $kanji_var,-font => $kanji_font_huge)->pack(-fill => 'both', -expand => 1);
my $kanji_notes = $example_frm->NoteBook( )->pack(-expand => 1, -fill => 'both');

my $default_漢字 = "零";
my %tab_txts;
$tab_txts{$default_漢字} = $default_漢字;
my %the_tabs;
my $example_box;
my %example_boxes;
my %tab_contents;
$tab_contents{$default_漢字} = $radical_stump;
&fill_notebook;

MainLoop;

sub fill_notebook {
    &empty_notebook if (%the_tabs);
    foreach (sort keys %tab_txts) {
	$the_tabs{$_} = $kanji_notes->add($tab_txts{$_}, -label => $tab_txts{$_});
	$example_boxes{$_} = $the_tabs{$_}->Scrolled("ROText",-scrollbars => 'oe');
	$example_boxes{$_}->configure(-font => $example_font, -wrap => 'word', width => '80', -height => '10', -tabs => [qw(0.5i left)]);
	$example_boxes{$_}->pack(-expand => 1, -fill => 'both');
	$example_boxes{$_}->insert('end',$tab_contents{$_});
    }
}

sub empty_notebook {
    foreach (keys %the_tabs) {
#	print "$_\n";
#	$example_boxes{$_}->delete("1.0",'end');
	$example_boxes{$_}->destroy;
	$kanji_notes->delete($_);
	delete $example_boxes{$_};
	delete $the_tabs{$_};
	delete $tab_txts{$_};
    }
}

sub draw_kanji {
    my $kanji_to_draw = $_[0] ? ${$_[0]} : "零";
    $kanji_lbl->configure(
	-font => $kanji_font_huge,
	-text => $kanji_to_draw,
	);
    $display_select = $button_txt{'b_kanji'};
    $tab_txts{$kanji_to_draw} = $kanji_to_draw;
    $tab_contents{$kanji_to_draw} = $radical_stump;
    &fill_notebook;
}

sub print_english {
    my @input = @{$kanji_data{$kanji_var}{$display_select}};
    my $words_to_print = "";
    foreach (@input) {
    	$words_to_print .= $_;
	$words_to_print .= "\n";
    }
    substr($words_to_print,-1,1,"");
    $kanji_lbl->configure(
	-font => $stroke_order_font,
	-text => $kanji_var,
	);
    $tab_txts{$button_txt{b_ei}} = $button_txt{b_ei};
    $tab_contents{$button_txt{b_ei}} = $words_to_print;
    &fill_notebook;
}

sub print_kana {
    my $kana_to_print = "";
    my $examples_to_print = "";
    my @example_words = "";
    my $the_word = "";
    foreach (keys %{$kanji_data{$kanji_var}{$display_select}}) {
	@example_words = @{$kanji_data{$kanji_var}{$display_select}{$_}};
	$" = "、";
	if ($_ ne "0") {
	    $examples_to_print .= "$_：\n";
	    } elsif (@example_words) {
		$examples_to_print .= "義訓（ぎくん）：\n";
	    }
	foreach $the_word (@example_words) {
	    $examples_to_print .= "$the_word";
	    if (exists $word_data{$the_word}) {
		$examples_to_print .= "（@{$word_data{$the_word}{平仮名}}）：";
		$examples_to_print .= "\n" if (!exists $word_data{$the_word}{英}{'0'});
		foreach (sort keys %{$word_data{$the_word}{英}}) {
		    $examples_to_print .= "\t($_) " if ($_);
		    $examples_to_print .= "@{$word_data{$the_word}{英}{$_}}\n";
		}
	    } else {
		$examples_to_print .= "、";
	    }
	}
	substr($examples_to_print,-1,1,"\n");
	$kana_to_print .= ($_ ne "0") ? "$_\n" : "\n";
	$_ = ($_ ne "0") ? "$_" : "義訓（ぎくん）";
	$tab_txts{$_} = $_;
	$tab_contents{$_} = $examples_to_print;
	$examples_to_print = "";
    }
#    $example_box->insert('end',$examples_to_print);
    $kanji_lbl->configure(
	-font => $stroke_order_font,
	-text => $kanji_var,
	);
    &fill_notebook;
}

sub exit_warning() {
    my $balloon;
    $balloon = $mw->Balloon(
	-state => 'balloon'
	);
    if (! Exists($ww)) {
	$ww = $mw->Toplevel;
	$ww->title('確認（かくにん）');
	my $warn_lbl = $ww->Label(
	    -text => '終了ですか？',
	    -font => $kanji_font_small,
	    )->pack(-ipadx => '0.25i', -ipady => '0.25i');
	$balloon->attach($warn_lbl,
			 -balloonmsg => "しゅうりょうですか？",
			 -balloonposition => 'mouse',
	    );
	my $ww_exit_btn = $ww->Button(-text => '終了',
				      -font => $kanji_font_small,
				      -command => sub {
					  print "\n";
					  $mw->destroy;
				      },
	    )->pack(-side => "left", -expand => 1, -padx => 5);
	$balloon->attach($ww_exit_btn,
			 -balloonmsg => "しゅうりょう",
			 -balloonposition => 'mouse',
	    );
	my $ww_cancel_btn = $ww->Button(-text => 'キャンセル',
					-font => $kanji_font_small,
					-command => sub {$ww->withdraw}
	    )->pack(-side => "left", -expand => 1, -padx => 5);
	$balloon->attach($ww_cancel_btn,
			 -balloonmsg => "きゃんせる",
			 -balloonposition => 'mouse',
	    );
    }
    else {
	$ww->deiconify;
	$ww->raise;
    }
}
