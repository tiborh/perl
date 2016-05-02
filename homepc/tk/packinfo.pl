#!/usr/bin/perl -w

use Tk;
use utf8;

my $kanji_font = "Helvetica -18";
my $normal_font = "Helvetica -12";
my $greeting = "今晩は\n（こんばんは）";
my $mw = MainWindow->new;
$mw->title("今晩は！");
my $test_lbl = $mw->Label(
    -text => $greeting,
    -font => $kanji_font,
    )->pack(-ipadx => 10,-ipady => 5);
my $info_btn = $mw->Button(
    -text => "Info", 
    -command => \&give_info, 
    -width => 20
    )->pack;
$mw->Button(-text => "Done", -command => sub{exit}, -width => 20)->pack;
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
