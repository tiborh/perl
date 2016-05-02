#!/usr/bin/perl -w

use Tk;
use utf8;

my $kanji_font_huge = "Times -18";
my $kanji_font = "Helvetica -18";
my $normal_font = "Helvetica -12";
my $greeting = "今晩は\n（こんばんは）";
my %button_txt = (
    b_prev => "前",
    b_next => "次",
    b_on => "音",
    b_kun => "訓",
    b_kanji => "漢",
    b_exit => "出",
    );

# Main Window
my $mw = MainWindow->new;
$mw->title("漢字");

# Control Buttons
$mw->Button(-text => $button_txt{"b_prev"}, -command => \&give_info)->grid(
            $mw->Button(-text => 'Button2', -command => \&give_info),
            $mw->Button(-text => 'Button3', -command => \&give_info),
            $mw->Button(-text => 'Button4', -command => \&give_info));

#$mw->Button(-text => "Done", -command => sub{exit}, -width => 20)->pack;

# Card area
my $central_lbl = $mw->Label(
    -text => $greeting,
    -font => $kanji_font,
    )->pack(-ipadx => 10,-ipady => 5);

MainLoop;

sub give_info {
    my @the_list = $test_lbl->packInfo();
    $test_lbl->configure(
	-font => $normal_font,
	-text => "@the_list",
	);
    $info_btn->configure(
	-text => "Restore", 
	-command => \&restore_greeting, 
	);
}

sub restore_greeting {
    $test_lbl->configure(
	-font => $kanji_font,
	-text => "$greeting",
	);
    $info_btn->configure(
	-text => "Info", 
	-command => \&give_info, 
	);
}
