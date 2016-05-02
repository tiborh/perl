#!/usr/bin/perl -w

use strict;
use utf8;
use Tk;
use Tk::Balloon;
use 5.010;

binmode STDOUT, 'encoding(UTF-8)';
binmode STDIN, 'encoding(UTF-8)';

my $kanji_font = "Times -24";
my $kanji_font_small = "Times -18";

# other windows
my $ww;
my $sw;

# Main Window
my $mw = MainWindow->new;
$mw->title("仮名（かな）");
$mw->minsize(qw(400 250));

my @平仮名五十音 = (
    [qw(あ か さ た な は ま や ら わ)],
    [qw(い き し ち に ひ み ∅ り ゐ)],
    [qw(う く す つ ぬ ふ む ゆ る ∅)],
    [qw(え け せ て ね へ め ∅ れ ゑ)],
    [qw(お こ そ と の ほ も よ ろ を)],
    [qw(ん)],
    );

my @片仮名五十音 = (
    [qw(ア カ サ タ ナ ハ マ ヤ ラ ワ)],
    [qw(イ キ シ チ ニ ヒ ミ ∅ リ ヰ)],
    [qw(ウ ク ス ツ ヌ フ ム ユ ル ∅)],
    [qw(エ ケ セ テ ネ ヘ メ ∅ レ ヱ)],
    [qw(オ コ ソ ト ノ ホ モ ヨ ロ ヲ)],
    [qw(ン)],
    );

my %仮名_btns;
my %仮名_var;

my $仮名一 = $ARGV[0] ? \@片仮名五十音 : \@平仮名五十音;
my $仮名二 = $ARGV[0] ? \@平仮名五十音 : \@片仮名五十音;

my $primary_仮名 = $仮名一;
my $secondary_仮名 = $仮名二;

my $push_btn_var = 0;
my $push_btn;
my $push_btn_balloon_txt = "すべてのぼたんをおす";

$mw->bind('<Control-Key-a>' => \&init_select_all_action);
$mw->bind('<Control-Key-r>' => \&sel_reset_btn_action);
$mw->bind('<Control-Key-s>' => \&swap_buttons);
$mw->bind('<Control-Key-q>' => sub {$mw->destroy});

&draw_kana_table($仮名一,$仮名二,\%仮名_btns,\%仮名_var,\$primary_仮名,\$secondary_仮名);

# Menu
$mw->configure(-menu => my $menubar = $mw->Menu);
my $プログラム = $menubar->cascade(
    -label => '~プログラム', 
    -menuitems => &プログラム_menuitems);
# my $フォント = $menubar->cascade(
#     -label => '~フォント', 
#     -menuitems => &フォント_menuitems);
my $インフォ = $menubar->cascade(
    -label => '~インフォ', 
    -menuitems => &インフォ_menuitems);

MainLoop;

# menu items
sub プログラム_menuitems {
    [
     ['command', '全て選択', -command => \&init_select_all_action,
      -accelerator => 'Ctrl-a',
     ],
     ['command', 'リセット', -command => \&sel_reset_btn_action,
      -accelerator => 'Ctrl-r',
     ],
     ['command', 'スワップ', -command => \&swap_buttons,
      -accelerator => 'Ctrl-s',
     ],
     '',
     ['command', '出', -command => \&exit_warning,
      -accelerator => 'Ctrl-q',
     ],
    ];
}

# sub フォント_menuitems {

# }

sub インフォ_menuitems {
    [
      ['command', 'バージョン', -command => [\&simple_dialog,"バージョン","バージョン：０.１"]],
      ['command', '就いて', -command => [\&simple_dialog,"就いて（ついて）","BY\n春茶\n智謀\n２０１２"]],
    ];
}

sub draw_kana_table {
    my $balloon;
    $balloon = $mw->Balloon(
	-state => 'balloon'
	);
# Kana Buttons
    my @仮名一 = @{$_[0]};
    my @仮名二 = @{$_[1]};
    my $grid_row;
    my $grid_col;

    for $grid_row (0..$#仮名一) {
	for $grid_col (0..$#{$仮名一[$grid_row]}) {
	    next if ($仮名一[$grid_row][$grid_col] eq "∅");
	    $仮名_btns{$仮名一[$grid_row][$grid_col]} = $mw->Checkbutton(
		-text => $仮名一[$grid_row][$grid_col],
		-font => $kanji_font,
		-variable => \$仮名_var{$仮名一[$grid_row][$grid_col]}, 
		-indicatoron => 0,
		-relief => 'flat',
		-command => [
		     \&change_btn_txt,
		     \$grid_row,
		     \$grid_col,
		],
		-width => 3,
		)->grid(
		-sticky => "nsew",
		-column => $grid_col,
		-row => $grid_row,
		);
	}
    }

    my ($grid_columns, $grid_rows) = $mw->gridSize( );
    
    $push_btn = $mw->Checkbutton(
	-text => "全てのボタンを押す",
	-font => $kanji_font_small,
	-variable => \$push_btn_var,
	-indicatoron => 0,
	-command => \&sel_push_btn_action,
	-width => 3,
	)->grid(-columnspan => $grid_columns,
		-sticky => "nsew",
	);
	$balloon->attach($push_btn,
			 -balloonmsg => \$push_btn_balloon_txt,
			 -balloonposition => 'mouse',
	    );
}

sub swap_buttons {
    my @kana1 = @{$仮名一};
    my @kana2 = @{$仮名二};
    my $kana_row;
    my $kana_col;
    foreach $kana_row (0..$#kana1) {
	foreach $kana_col (0..$#{$kana1[$kana_row]}) {
	    next if ($kana1[$kana_row][$kana_col] eq "∅");
	    $仮名_btns{$kana1[$kana_row][$kana_col]}->configure(
		-text => $secondary_仮名->[$kana_row][$kana_col]);
	}
    }
    ($primary_仮名,$secondary_仮名) = ($secondary_仮名,$primary_仮名);
    &sel_reset_btn_action if ($push_btn_var);
}

sub init_select_all_action {
    unless ($push_btn_var) {
	$push_btn_var = 1;
	&sel_push_btn_action;
    } else {
	&sel_reset_btn_action;
    }
}

sub sel_push_btn_action {
    state $old_name;
    state $old_balloon_name;
    my $new_name = 'リセット';
    if ($push_btn_var) {
	$old_name = $push_btn->cget(-text);
	&push_buttons;
	$push_btn->configure(-text => $new_name);
	$old_balloon_name = $push_btn_balloon_txt;
	$push_btn_balloon_txt = $new_name;
    } else {
	&reset_buttons;
	$push_btn->configure(-text => $old_name);
	$push_btn_balloon_txt = $old_balloon_name;
    }
}

sub change_btn_txt {
    my $grid_row = ${$_[0]};
    my $grid_col = ${$_[1]};
    my $the_button = $仮名_btns{$仮名一->[$grid_row][$grid_col]};
    my $the_variable = $仮名_var{$仮名一->[$grid_row][$grid_col]};
    my $unpressed_kana = $primary_仮名->[$grid_row][$grid_col];
    my $pressed_kana = $secondary_仮名->[$grid_row][$grid_col];

    $the_button->configure(-text => ($the_variable ? $pressed_kana : $unpressed_kana));
}

sub sel_reset_btn_action {
    if ($push_btn_var) {
	$push_btn_var = 0;
	&sel_push_btn_action;
    } else {
	&reset_buttons;
    }
}

sub reset_buttons {
    my %the_grid_info;
    my $the_grid_element;
    my $gridx = 0;
    my $gridy = 0;
    my $button_txt;

    foreach (keys %仮名_var) {
	if ($仮名_var{$_}) {
	    $the_grid_element = $仮名_btns{$_};
	    %the_grid_info = $the_grid_element->gridInfo();
	    $gridx = $the_grid_info{'-row'};
	    $gridy = $the_grid_info{'-column'};
	    $仮名_btns{$仮名一->[$gridx][$gridy]}->configure(
		-text => $primary_仮名->[$gridx][$gridy]);
	    $仮名_var{$仮名一->[$gridx][$gridy]} = 0;
	}
    }
}

sub push_buttons {
    my %the_grid_info;
    my $the_grid_element;
    my $gridx = 0;
    my $gridy = 0;
    foreach (keys %仮名_var) {
	$仮名_var{$_} = 1;
	$the_grid_element = $仮名_btns{$_};
	%the_grid_info = $the_grid_element->gridInfo();
	$gridx = $the_grid_info{'-row'};
	$gridy = $the_grid_info{'-column'};
	$仮名_btns{$仮名一->[$gridx][$gridy]}->configure(
	    -text => $secondary_仮名->[$gridx][$gridy]);
    }
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

sub simple_dialog {
    if (! Exists($sw)) {
	$sw = $mw->Toplevel;
	$sw->title($_[0]);
	$sw->minsize(qw(150 150));
	my $custom_lbl = $sw->Label(
	    -text => $_[1],
	    -font => $kanji_font_small,
	    )->place(
	    -anchor => 'center',
	    -relx => 0.5,
	    -rely => 0.35,
	    );
	my $my_ok_btn = $sw->Button(-text => '良い',
					-font => $kanji_font_small,
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
