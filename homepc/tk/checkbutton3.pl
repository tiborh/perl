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

&create_buttons(\$mw);

MainLoop;

sub create_buttons {
    my $mw = ${$_[0]};
    my $cb_value = 0;
    my $cb;
    $cb = $mw->Checkbutton(
	-indicatoron => 0,
	-text => "あ",
	-font => $kanji_font,
	-variable => \$cb_value,
	-width => 5,
	-height => 2,
	-command => [\&change_btn_txt,\$cb,\$cb_value],
	);

    my $exit_btn = $mw->Button(-text => '終了',
			       -font => $kanji_font,
			       -command => sub {
				   $mw->destroy;
			       },
	);

    my $reset_btn = $mw->Button(-text => 'リセット',
				-font => $kanji_font,
				-command => [\&reset_check_button,\$cb,\$cb_value]
	);

    my $cb_width = -($cb->reqwidth()/2);
    my $cb_height = -($cb->reqheight()/2);
    my $exit_btn_width = -($exit_btn->reqwidth()/2);
    my $reset_btn_width = -($reset_btn->reqwidth()/2);

    $cb->form(
	-top => ['%50', $cb_height],
	-left => ['%50', $cb_width],
	);

    $exit_btn->form(
	-top => [$cb],
	-left => ['%50', $exit_btn_width],
	);

    $reset_btn->form(
	-left => ['%50', $reset_btn_width],
	);
}

sub change_btn_txt {
    my $cb = ${$_[0]};
    my $cb_value = ${$_[1]};
    print "$cb_value\n";
    $cb->configure(-text => ($cb_value ? "ア" : "あ"));
}

sub reset_check_button {
    ${$_[1]} = 0;
    &change_btn_txt(\${$_[0]},\${$_[1]});
}
