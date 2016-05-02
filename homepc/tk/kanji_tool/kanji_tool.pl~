#!/usr/bin/perl -w

use strict;
use Tk;
use Tk::Balloon;
require Tk::ROText;
use utf8;
use encoding 'utf8';

my $kanji_font_huge = "Times -144";
my $kanji_font = "Times -24";
my $example_font = "Times -18";
my $normal_font = "Helvetica -14";
my $stroke_order_font = "KanjiStrokeOrders -144";
my $kanji_font_small = $example_font;
#my $greeting = "今晩は\n（こんばんは）";
my %kanji_data = (
    日 => {			# １９１５
	音 => {
	    ニチ => [qw(日夜 日中 毎日 今日 一日 日本 土日)],
	    ジツ => [qw(本日 平日 日月)],
	},
	訓 => {
	    ひ => [qw(日時計 日の出 日の入り 朝日 日々 日に日に)],
	    ーび => [qw(日曜日 誕生日)],
	    ーか =>  [qw(三日前 十月十日)],
	    },
	義 => {
	    0 => [qw(今日 一日 明日 昨日)], # 義訓（ぎくん）
	},
	英 => [qw(day sun Japan)],
    },
    木 => {			# ２１４９
	音 => {
	    ボク => [qw(木石 香木 原木)],
	    モク => [qw(草木 木材 木造の)],
	},
	訓 => {
	    き => [qw(植木 苗木 木登り 木彫り 白木)],
	    ーこ => [qw(木陰 木立)],
	},
	義 => {
	    0 => [qw(木綿)],
	},
	英 => [qw(tree wood)],
    },
    本 => {			# ２１８３
	音 => {
	    ホン => [qw(日本 本国 本来 見本 手本 本屋 読本 本日 本年 本土 本当に 本名 八本の鉛筆)],
	},
	訓 => {
	    もと => [qw(国の本 一本の草)],
	},
	義 => { 
	    0 => [qw()], 
	},
	英 => [qw(basis book this)],
    },
    末 => {			# ２１８４
	音 => {
	    マツ => [qw(末尾 年末 週末 結末 末日 本末 末端 粉末 月末 末期 末期的)],
	    バツ => [qw(末弟 末流)],
	},
	訓 => {
	    すえ => [qw(三月の末 末っ子 末に 末の末 末々)],
	},
	義 => {
	    0 => [qw(末枯れ 末若い 末葉)],
	},
	英 => ["last part"],
    },
    未 => {			# ２１８５
	音 => {
	    ミ => [qw(未来 未知の 未定の 前代未聞の)],
	},
	訓 => {
	    "いま·だ" => [qw(未だ嘗て無偉大な人)],
	    "ま·だ" => [qw(彼は未だ来ていない)],
	},
	義 => { 
	    0 => [qw()], 
	},
	英 => ["not yet"],
    },
    零 => {			# １７８６
	音 => {
	    レイ => [qw(零下 零時 零点 零細)],
	},
	訓 => {
	    "こぼ·す" => [qw(落ち零れ 零す 取零す 零れる)],
	},
	義 => {
	    0 => [qw(零戦)],
	},
	英 => [qw(zero)],
    },
    );

my %word_data = (
    日夜 => {
	平仮名 => [qw(にちや)],
	英 => {
	    0 => ["day and night"],
	},
	例 => {
	    一 => {
	       日 => "看護婦達は、日夜患者の世話を為た。",
	       平 => "かんごふたちは、にちやかんじゃのせわおした。",
	       英 => "The nurses attend to the patient day and night.",
	    },
	    二 => {
	       日 => "彼は金持ちになる為に、日夜働いた。",
	       平 => "かれはかねもちになるために、にちやはたらいた。",
	       英 => "He worked day and night so that he might become rich.",
	    },
	    三 => {
	       日 => "私は昨日夜遅く迄起きていた。",
	       平 => "わたしはさくじつ（きのう）よるおそくまでおきていた。",
	       英 => "I stayed up late last night.",
	    },
	},
    },
    日中 => {
	平仮名 => [qw(にっちゅう)],
	英 => {
	    0 => ["during the day"],
	},
	例 => {
	    一 => {
	       日 => "",
	       平 => "",
	       英 => "",
	    },
	    二 => {
	       日 => "",
	       平 => "",
	       英 => "",
	    },
	    三 => {
	       日 => "",
	       平 => "",
	       英 => "",
	    },
	},
    },
    毎日 => {
	平仮名 => [qw(まいにち)],
	英 => {
	    0 => ["every day"],
	},
	例 => {
	    一 => {
		日 => "",
		平 => "",
		英 => "",
	    },
	    二 => {
		日 => "",
		平 => "",
		英 => "",
	    },
	},
    },
    今日 => {
	平仮名 => [qw(こんにち)],
	英 => {
	    1 => ["today", "this day"],
	    2 => ["these days","recently","nowadays"],
	},
	例 => {
	    一 => {
		日 => "",
		平 => "",
		英 => "",
	    },
	    二 => {
		日 => "",
		平 => "",
		英 => "",
	    },
	},
    },
    一日 => {
	平仮名 => [qw(いちにち いちじつ ついたち つきたち いっぴ)],
	英 => {
	    1 => ["first day of the month (いっぴ's only meaning)"],
	    2 => ["one day (いちにち、いちじつ)"],
	    3 => ["first 10 days of the lunar month (つきたち)"],
	},
	例 => {
	    一 => {
	       日 => "",
	       平 => "",
	       英 => "",
	    },
	    二 => {
	       日 => "",
	       平 => "",
	       英 => "",
	    },
	},
    },
    日本 => {
	平仮名 => [qw(にっぽん にほん)],
	英 => {
	    0 => [qw(Japan)],
	},
	例 => {
	    一 => {
	       日 => "",
	       平 => "",
	       英 => "",
	    },
	    二 => {
	       日 => "",
	       平 => "",
	       英 => "",
	    },
	},
    },
    本日 => {
	平仮名 => [qw(ほんじつ)],
	英 => {
	    0 => [qw(today)],
	},
	例 => {
	    一 => {
	       日 => "",
	       平 => "",
	       英 => "",
	    },
	    二 => {
	       日 => "",
	       平 => "",
	       英 => "",
	    },
	},
    },
    平日 => {
	平仮名 => [qw(へいじつ)],
	英 => {
	    0 => [qw(weekday)],
	},
	例 => {
	    一 => {
	       日 => "",
	       平 => "",
	       英 => "",
	    },
	    二 => {
	       日 => "",
	       平 => "",
	       英 => "",
	    },
	},
    },
    日月 => {
	平仮名 => [qw(じつげつ)],
	英 => {
	    0 => ["sun and moon", "time", "days", "years"],
	},
        例 => {
	    一 => {
		日 => "",
		平 => "",
		英 => "",
	    },
	    二 => {
		日 => "",
		平 => "",
		英 => "",
	    },
        },
    },
    土日 => {
	平仮名 => [qw(どにち)],
	英 => {
	    0 => ["Saturday and Sunday", "weekend"],
	},
        例 => {
	    一 => {
		日 => "",
		平 => "",
		英 => "",
	    },
	    二 => {
		日 => "",
		平 => "",
		英 => "",
	    },
	    三 => {
	       日 => "",
	       平 => "",
	       英 => "",
	    },
        },
    },
    日時計 => {
	平仮名 => [qw(ひどけい)],
	英 => {
	    0 => ["sundial"],
	},
        例 => {
	    一 => {
		日 => "",
		平 => "",
		英 => "",
	    },
	    二 => {
		日 => "",
		平 => "",
		英 => "",
	    },
	    三 => {
	       日 => "",
	       平 => "",
	       英 => "",
	    },
        },
    },
    日の出 => {
	平仮名 => [qw(ひので)],
	英 => {
	    0 => ["sunrise"],
	},
        例 => {
	    一 => {
		日 => "初日の出",
		平 => "はつひので",
		英 => "first sunrise (of the New Year)",
	    },
	    二 => {
		日 => "",
		平 => "",
		英 => "",
	    },
	    三 => {
	       日 => "",
	       平 => "",
	       英 => "",
	    },
        },
    },
    日の入り => {
	平仮名 => [qw(ひのいり)],
	英 => {
	    0 => ["sunset"],
	},
        例 => {
	    一 => {
		日 => "",
		平 => "",
		英 => "",
	    },
	    二 => {
		日 => "",
		平 => "",
		英 => "",
	    },
	    三 => {
	       日 => "",
	       平 => "",
	       英 => "",
	    },
        },
    },
    朝日 => {
	平仮名 => [qw(あさひ)],
	英 => {
	    0 => ["morning sun"],
	},
        例 => {
	    一 => {
		日 => "",
		平 => "",
		英 => "",
	    },
	    二 => {
		日 => "",
		平 => "",
		英 => "",
	    },
	    三 => {
	       日 => "",
	       平 => "",
	       英 => "",
	    },
        },
    },
    朝日影 => {
	平仮名 => [qw(あさひかげ)],
	英 => {
	    0 => ["morning sunlight"],
	},
        例 => {
	    一 => {
		日 => "",
		平 => "",
		英 => "",
	    },
	    二 => {
		日 => "",
		平 => "",
		英 => "",
	    },
	    三 => {
	       日 => "",
	       平 => "",
	       英 => "",
	    },
        },
    },
    日々 => {
	平仮名 => [qw(ひび にちにち)],
	英 => {
	    0 => ["every day", "daily", "day after day", "(good old) days"],
	},
        例 => {
	    一 => {
		日 => "",
		平 => "",
		英 => "",
	    },
	    二 => {
		日 => "",
		平 => "",
		英 => "",
	    },
	    三 => {
	       日 => "",
	       平 => "",
	       英 => "",
	    },
        },
    },
    日に日に => {
	平仮名 => [qw(ひにひに)],
	英 => {
	    1 => ["day by day", "by the day"],
	    2 => ["(arch) daily", "(arch) every day"],
	},
        例 => {
	    一 => {
		日 => "",
		平 => "",
		英 => "",
	    },
	    二 => {
		日 => "",
		平 => "",
		英 => "",
	    },
	    三 => {
	       日 => "",
	       平 => "",
	       英 => "",
	    },
        },
    },
    三日前 => {
	平仮名 => [qw(さんにちまえ)],
	英 => {
	    0 => ["three days ago"],
	},
        例 => {
	    一 => {
		日 => "三日前、トムは去った。",
		平 => "さんにちまえ、とむはさった。",
		英 => "Tom left three days ago.",
	    },
	    二 => {
		日 => "三日前、旧友にひょっこり会った。",
		平 => "さんにちまえ、きゅうゆうにひょっこりあった。",
		英 => "I ran into an old friend three days ago.",
	    },
	    三 => {
	       日 => "",
	       平 => "",
	       英 => "",
	    },
        },
    },
    十月十日 => {
	平仮名 => [qw(とつきとおか)],
	英 => {
	    1 => ["babies born on October 10", "supposedly conceived on New Year's Day"],
	    2 => ["normal gestation time (i.e. 9 months)"],
	},
        例 => {
	    一 => {
		日 => "",
		平 => "",
		英 => "",
	    },
	    二 => {
		日 => "",
		平 => "",
		英 => "",
	    },
	    三 => {
	       日 => "",
	       平 => "",
	       英 => "",
	    },
        },
    },
    日曜日 => {
	平仮名 => [qw(にちようび)],
	英 => {
	    0 => ["Sunday"],
	},
        例 => {
	    一 => {
		日 => "",
		平 => "",
		英 => "",
	    },
	    二 => {
		日 => "",
		平 => "",
		英 => "",
	    },
	    三 => {
	       日 => "",
	       平 => "",
	       英 => "",
	    },
        },
    },
    誕生日 => {
	平仮名 => [qw(たんじょうび)],
	英 => {
	    0 => ["birthday"],
	},
        例 => {
	    一 => {
		日 => "",
		平 => "",
		英 => "",
	    },
	    二 => {
		日 => "",
		平 => "",
		英 => "",
	    },
	    三 => {
	       日 => "",
	       平 => "",
	       英 => "",
	    },
        },
    },
    今日 => {
    	平仮名 => [qw(きょう こんにち こんじつ)],
    	英 => {
	    0 => ["today", "this day"],
	},
        例 => {
    	    一 => {
    		日 => "",
    		平 => "",
    		英 => "",
    	    },
    	    二 => {
    		日 => "",
    		平 => "",
    		英 => "",
    	    },
    	    三 => {
    	       日 => "",
    	       平 => "",
    	       英 => "",
    	    },
        },
    },
    明日 => {
    	平仮名 => [qw(あした あす みょうにち)],
    	英 => {
	    0 => ["tomorrow"],
	},
        例 => {
    	    一 => {
    		日 => "",
    		平 => "",
    		英 => "",
    	    },
    	    二 => {
    		日 => "",
    		平 => "",
    		英 => "",
    	    },
    	    三 => {
    	       日 => "",
    	       平 => "",
    	       英 => "",
    	    },
        },
    },
    昨日 => {
    	平仮名 => [qw(きのう さくじつ)],
    	英 => {
	    0 => ["yesterday"],
	},
        例 => {
    	    一 => {
    		日 => "",
    		平 => "",
    		英 => "",
    	    },
    	    二 => {
    		日 => "",
    		平 => "",
    		英 => "",
    	    },
    	    三 => {
    	       日 => "",
    	       平 => "",
    	       英 => "",
    	    },
        },
    },
    #  => {
    # 	平仮名 => [qw()],
    # 	英 => {
    # 	    0 => [""],
    # 	},
    #     例 => {
    # 	    一 => {
    # 		日 => "",
    # 		平 => "",
    # 		英 => "",
    # 	    },
    # 	    二 => {
    # 		日 => "",
    # 		平 => "",
    # 		英 => "",
    # 	    },
    # 	    三 => {
    # 	       日 => "",
    # 	       平 => "",
    # 	       英 => "",
    # 	    },
    #     },
    # },
    #  => {
    # 	平仮名 => [qw()],
    # 	英 => {
    # 	    0 => [""],
    # 	},
    #     例 => {
    # 	    一 => {
    # 		日 => "",
    # 		平 => "",
    # 		英 => "",
    # 	    },
    # 	    二 => {
    # 		日 => "",
    # 		平 => "",
    # 		英 => "",
    # 	    },
    # 	    三 => {
    # 	       日 => "",
    # 	       平 => "",
    # 	       英 => "",
    # 	    },
    #     },
    # },
    #  => {
    # 	平仮名 => [qw()],
    # 	英 => {
    # 	    0 => [""],
    # 	},
    #     例 => {
    # 	    一 => {
    # 		日 => "",
    # 		平 => "",
    # 		英 => "",
    # 	    },
    # 	    二 => {
    # 		日 => "",
    # 		平 => "",
    # 		英 => "",
    # 	    },
    # 	    三 => {
    # 	       日 => "",
    # 	       平 => "",
    # 	       英 => "",
    # 	    },
    #     },
    # },
    #  => {
    # 	平仮名 => [qw()],
    # 	英 => {
    # 	    0 => [""],
    # 	},
    #     例 => {
    # 	    一 => {
    # 		日 => "",
    # 		平 => "",
    # 		英 => "",
    # 	    },
    # 	    二 => {
    # 		日 => "",
    # 		平 => "",
    # 		英 => "",
    # 	    },
    # 	    三 => {
    # 	       日 => "",
    # 	       平 => "",
    # 	       英 => "",
    # 	    },
    #     },
    # },
    #  => {
    # 	平仮名 => [qw()],
    # 	英 => {
    # 	    0 => [""],
    # 	},
    #     例 => {
    # 	    一 => {
    # 		日 => "",
    # 		平 => "",
    # 		英 => "",
    # 	    },
    # 	    二 => {
    # 		日 => "",
    # 		平 => "",
    # 		英 => "",
    # 	    },
    # 	    三 => {
    # 	       日 => "",
    # 	       平 => "",
    # 	       英 => "",
    # 	    },
    #     },
    # },
    #  => {
    # 	平仮名 => [qw()],
    # 	英 => {
    # 	    0 => [""],
    # 	},
    #     例 => {
    # 	    一 => {
    # 		日 => "",
    # 		平 => "",
    # 		英 => "",
    # 	    },
    # 	    二 => {
    # 		日 => "",
    # 		平 => "",
    # 		英 => "",
    # 	    },
    # 	    三 => {
    # 	       日 => "",
    # 	       平 => "",
    # 	       英 => "",
    # 	    },
    #     },
    # },
    );

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
my $example_box = $example_frm->Scrolled("ROText",-scrollbars => 'oe');
$example_box->configure(-font => $example_font, -wrap => 'word', width => '80', -height => '10', -tabs => [qw(0.5i left)]);
$example_box->pack(-expand => 1, -fill => 'both');
$example_box->insert('end',$radical_stump);

MainLoop;

sub draw_kanji {
    my $kanji_to_draw = $_[0] ? ${$_[0]} : "零";
    $kanji_lbl->configure(
	-font => $kanji_font_huge,
	-text => $kanji_to_draw,
	);
    $display_select = $button_txt{'b_kanji'};
    $example_box->delete("1.0",'end');
    $example_box->insert('end',$radical_stump);
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
    $example_box->delete("1.0",'end');
    $example_box->insert('end',$words_to_print);    
}

sub print_kana {
    my $kana_to_print = "";
    my $examples_to_print = "";
    my @example_words = "";
    my $the_word = "";
    foreach (keys %{$kanji_data{$kanji_var}{$display_select}}) {
	@example_words = @{$kanji_data{$kanji_var}{$display_select}{$_}};
	$" = "、";
	$examples_to_print .= ($_ ne "0") ? "$_\n" : "義訓（ぎくん）\n";
	foreach $the_word (@example_words) {
	    $examples_to_print .= "\t$the_word";
	    if (exists $word_data{$the_word}) {
		$examples_to_print .= "（@{$word_data{$the_word}{平仮名}}）：";
		$examples_to_print .= "\n" if (!exists $word_data{$the_word}{英}{'0'});
		foreach (sort keys %{$word_data{$the_word}{英}}) {
		    $examples_to_print .= "\t\t($_) " if ($_);
		    $examples_to_print .= "@{$word_data{$the_word}{英}{$_}}\n";
		}
	    } else {
		$examples_to_print .= "、";
	    }
	}
	substr($examples_to_print,-1,1,"\n");
	$kana_to_print .= ($_ ne "0") ? "$_\n" : "\n";
    }
    $example_box->delete("1.0",'end');
    $example_box->insert('end',$examples_to_print);
    $kanji_lbl->configure(
	-font => $stroke_order_font,
	-text => $kanji_var,
	);
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
