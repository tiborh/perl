#!/usr/bin/perl -w

use Tk;
use Tk::Balloon;
use utf8;
use strict;
use 5.010;

binmode STDOUT, 'encoding(UTF-8)';

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

&draw_kana_table($仮名一,$仮名二,\%仮名_btns,\%仮名_var);


# Menu
$mw->configure(-menu => my $menubar = $mw->Menu);
my $プログラム = $menubar->cascade(
    -label => '~プログラム', 
    -menuitems => &プログラム_menuitems);
my $インフォ = $menubar->cascade(
    -label => '~インフォ', 
    -menuitems => &インフォ_menuitems);

MainLoop;

sub draw_kana_table {
    my $balloon;
    $balloon = $mw->Balloon(
	-state => 'balloon'
	);
# Kana Buttons
    my @仮名一 = @{$_[0]};
    my @仮名二 = @{$_[1]};
    my %仮名_btns = %{$_[2]};
    my %仮名_var = %{$_[3]};
    my $grid_row;
    my $grid_col;
    for $grid_row (0..$#仮名一) {
	for $grid_col (0..$#{$仮名一[$grid_row]}) {
	    next if ($仮名一[$grid_row][$grid_col] eq "∅");
	    $_[2]{$仮名一[$grid_row][$grid_col]} = $mw->Checkbutton(
		-text => $仮名一[$grid_row][$grid_col],
		-font => $kanji_font,
		-variable => \$_[3]{$仮名一[$grid_row][$grid_col]}, 
		-indicatoron => 0,
		-relief => 'flat',
		-command => [
		     \&change_btn_txt,
		     \$_[2]{$仮名一[$grid_row][$grid_col]},
		     \$_[3]{$仮名一[$grid_row][$grid_col]},
		     \$仮名二[$grid_row][$grid_col],
		     \$仮名一[$grid_row][$grid_col],
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
    
    # my $reset_btn = $mw->Button(
    # 	-text => "リセット",
    # 	-font => $kanji_font_small,
    # 	-command => [
    # 	     \&reset_buttons,
    # 	     \@仮名一,
    # 	     \@仮名二,
    # 	     \%{$_[2]},
    # 	     \%{$_[3]},
    # 	],
    # 	-width => 3,
    # 	)->grid(-columnspan => $grid_columns,
    # 		-sticky => "nsew",
    # 	);

    my $push_btn_var = 0;
    my $push_btn;
    my $push_btn_balloon_txt = "すべてのぼたんをおす";
    $push_btn = $mw->Checkbutton(
	-text => "全てのボタンを押す",
	-font => $kanji_font_small,
	-variable => \$push_btn_var,
	-indicatoron => 0,
	-command => [
	     \&sel_push_btn_action,
	     \@仮名一,			# 0
	     \@仮名二,			# 1
	     \%{$_[2]},			# 2
	     \%{$_[3]},			# 3
	     \$push_btn_var,		# 4
	     \$push_btn,		# 5
	     \$push_btn_balloon_txt, 	# 6
	],
	-width => 3,
	)->grid(-columnspan => $grid_columns,
		-sticky => "nsew",
	);
	$balloon->attach($push_btn,
			 -balloonmsg => \$push_btn_balloon_txt,
			 -balloonposition => 'mouse',
	    );
}

sub sel_push_btn_action {
    state $old_name;
    state $old_balloon_name;
    my $new_name = 'リセット';
    if (${$_[4]}) {
	$old_name = ${$_[5]}->cget(-text);
	&push_buttons($_[0],$_[1],$_[2],$_[3]);
	${$_[5]}->configure(-text => $new_name);
	$old_balloon_name = ${$_[6]};
	${$_[6]} = $new_name;
    } else {
	&reset_buttons($_[0],$_[1],$_[2],$_[3]);
	${$_[5]}->configure(-text => $old_name);
	${$_[6]} = $old_balloon_name;
    }
}

sub change_btn_txt { 		# 0: $button, 1: value of checkbutton variable, 2: pressed kana, 3: unpressed kana
    my $cb = ${$_[0]};
    my $cb_value = ${$_[1]};
    my $仮名二 = ${$_[2]};
    my $仮名一 = ${$_[3]};

    $cb->configure(-text => ($cb_value ? $仮名二 : $仮名一));
    print $cb_value ? $仮名二 : $仮名一;
}

sub reset_buttons {
    my @仮名一 = @{$_[0]};
    my @仮名二 = @{$_[1]};
    my %仮名_btns = %{$_[2]};
    my %仮名_var = %{$_[3]};
    my %the_grid_info;
    my $the_grid_element;
    my $gridx = 0;
    my $gridy = 0;
    my $button_txt;

    #print %仮名_var;
    print "\n";
    foreach (keys %仮名_var) {
	if ($仮名_var{$_}) {
	    $the_grid_element = $仮名_btns{$_};
	    %the_grid_info = $the_grid_element->gridInfo();
	    $gridx = $the_grid_info{'-row'};
	    $gridy = $the_grid_info{'-column'};
	    $_[2]{$仮名一[$gridx][$gridy]}->configure(-text => $仮名一[$gridx][$gridy]);
	    $_[3]{$仮名一[$gridx][$gridy]} = 0;
	}
    }
}

sub push_buttons {
    my @仮名一 = @{$_[0]};
    my @仮名二 = @{$_[1]};
    my %the_grid_info;
    my $the_grid_element;
    my $gridx = 0;
    my $gridy = 0;
#    print "$_\n" foreach (@_);
    foreach (keys %{$_[3]}) {
#	print $_;
	$_[3]{$_} = 1;
	$the_grid_element = $仮名_btns{$_};
	%the_grid_info = $the_grid_element->gridInfo();
	$gridx = $the_grid_info{'-row'};
	$gridy = $the_grid_info{'-column'};
	$_[2]{$仮名一[$gridx][$gridy]}->configure(-text => $仮名二[$gridx][$gridy]);
    }
}

# menu items
sub プログラム_menuitems {
    [
     ['command', 'リセット', -command => [\&reset_buttons,$仮名一,$仮名二,\%仮名_btns,\%仮名_var]],
#     ['command', 'スワップ', -command => [\&swap_kana,$仮名一,$仮名二,\%仮名_btns,\%仮名_var]],
#     ['command', 'スワップ', -command => sub {print "\n"}],
     '',
     ['command', '出', -command => [\&send_warning]],
    ];
}

sub インフォ_menuitems {
    [
      ['command', 'バージョン', -command => [\&simple_dialog,"バージョン","バージョン：０.１"]],
      ['command', '就いて', -command => [\&simple_dialog,"就いて（ついて）","BY\n春茶\n智謀\n２０１２"]],
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
