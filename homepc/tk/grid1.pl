#!/usr/bin/perl -w

use Tk;
use Tk::Balloon;
use utf8;
use strict;

binmode STDOUT, 'encoding(UTF-8)';

my $kanji_font = "Helvetica -18";

# other windows
my $ww;
my $sw;

# Main Window
my $mw = MainWindow->new;
$mw->title("仮名（かな）");
$mw->minsize(qw(370 220));

my @平仮名五十音 = (
    [qw(あ か さ た な は ま や ら わ)],
    [qw(い き し ち に ひ み ∅ り ゐ)],
    [qw(う く す つ ぬ ふ む ゆ る ∅)],
    [qw(え け せ て ね へ め ∅ れ ゑ)],
    [qw(お こ そ と の ほ も よ ろ を)],
    [qw(ん)],
    );

my @片假名五十音 = (
    [qw(ア カ サ タ ナ ハ マ ヤ ラ ワ)],
    [qw(イ キ シ チ ニ ヒ ミ ∅ リ ヰ)],
    [qw(ウ ク ス ツ ヌ フ ム ユ ル ∅)],
    [qw(エ ケ セ テ ネ ヘ メ ∅ レ ヱ)],
    [qw(オ ク ソ ト ノ ホ モ ヨ ロ ヲ)],
    [qw(ン)],
    );

# Kana Buttons
my %五十音_btns;
my %五十音_var;
my $grid_row;
my $grid_col;
for $grid_row (0..$#平仮名五十音) {
    for $grid_col (0..$#{$平仮名五十音[$grid_row]}) {
	next if ($平仮名五十音[$grid_row][$grid_col] eq "∅");
	$五十音_btns{$平仮名五十音[$grid_row][$grid_col]} = $mw->Checkbutton(
	    -text => $平仮名五十音[$grid_row][$grid_col],
	    -font => $kanji_font,
	    -variable => \$五十音_var{$平仮名五十音[$grid_row][$grid_col]}, 
	    -indicatoron => 0,
	    -relief => 'flat',
	    -command => [
		 \&change_btn_txt,
		 \$五十音_btns{$平仮名五十音[$grid_row][$grid_col]},
		 \$五十音_var{$平仮名五十音[$grid_row][$grid_col]},
		 \$平仮名五十音[$grid_row][$grid_col],
		 \$片假名五十音[$grid_row][$grid_col],
	    ],
	    -width => 3,
	    )->grid(
	    -sticky => "nsew",
	    -column => $grid_col,
	    -row => $grid_row,
	    );
    }
}

# Menu
$mw->configure(-menu => my $menubar = $mw->Menu);
my $file = $menubar->cascade(
    -label => '~ファイル', 
    -menuitems => &file_menuitems);
my $help = $menubar->cascade(
    -label => '~ヘルプ', 
    -menuitems => &help_menuitems);

MainLoop;

sub change_btn_txt {
    my $cb = ${$_[0]};
    my $cb_value = ${$_[1]};
    my $仮名一 = ${$_[2]};
    my $仮名二 = ${$_[3]};

    $cb->configure(-text => ($cb_value ? $仮名二 : $仮名一));
    print $cb_value ? $仮名二 : $仮名一;
}

sub file_menuitems {
    [
#      ['command', 'リセット', -command => [\&uncheck_btns]],
#      '',
      ['command', '出', -command => [\&send_warning]],
    ];
}

# sub uncheck_btns {

# }

sub help_menuitems {
    [
      ['command', 'バージョン', -command => [\&simple_dialog,"バージョン","バージョン：０.１"]],
      ['command', '就いて', -command => [\&simple_dialog,"就いて（ついて）","BY 春茶智謀\n２０１２"]],
    ];
}

sub send_warning() {
    my $balloon;
    $balloon = $mw->Balloon(
	-state => 'balloon'
	);
    if (! Exists($ww)) {
	$ww = $mw->Toplevel;
	$ww->title('確認（かくにん）');
	my $warn_lbl = $ww->Label(
	    -text => '終了ですか？',
	    -font => $kanji_font,
	    )->pack(-ipadx => '0.25i', -ipady => '0.25i');
	$balloon->attach($warn_lbl,
			 -balloonmsg => "しゅうりょうですか？",
			 -balloonposition => 'mouse',
	    );
	my $ww_exit_btn = $ww->Button(-text => '終了',
				      -font => $kanji_font,
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
					-font => $kanji_font,
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

sub simple_dialog {
    if (! Exists($sw)) {
	$sw = $mw->Toplevel;
	$sw->title($_[0]);
	$sw->minsize(qw(150 150));
	my $custom_lbl = $sw->Label(
	    -text => $_[1],
	    -font => $kanji_font,
	    )->place(
	    -anchor => 'n',
	    -relx => 0.5,
	    -rely => 0.2,
	    );
	my $my_ok_btn = $sw->Button(-text => 'OK',
					-font => $kanji_font,
					-command => sub {$sw->destroy}
	    )->place(
	    -anchor => 'n',
	    -relx => 0.5,
	    -rely => 0.7,
	    );
    } else {
	$sw->deiconify;
	$sw->raise;
    }
}
