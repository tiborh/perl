#!/usr/bin/perl -w

use Tk;
use utf8;
use strict;

binmode STDOUT, 'encoding(UTF-8)';

my $kanji_font = "Helvetica -18";

# Main Window
my $mw = MainWindow->new;
$mw->title("Checkbutton");
$mw->minsize(qw(220 150));

my $cb_value = 0;
my $cb;
$cb = $mw->Checkbutton(
    -indicatoron => 0,
    -text => "あ",
    -font => $kanji_font,
    -variable => \$cb_value,
    -command => [\&change_btn_txt,\$cb,\$cb_value],
    )->place(
    -anchor => 'center',
    -relx => 0.5,
    -rely => 0.5,
    -relheight => 0.5,
    -relwidth => 0.5,
    );

MainLoop;

sub change_btn_txt {
    my $cb = ${$_[0]};
    my $cb_value = ${$_[1]};

    $cb->configure(-text => ($cb_value ? "ア" : "あ"));
}
