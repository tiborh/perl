#!/usr/bin/perl -w

use Tk;
use utf8;
use strict;

binmode STDOUT, 'encoding(UTF-8)';

my $kanji_font = "Helvetica -18";

# Main Window
my $mw = MainWindow->new;
$mw->title("メニュー");
$mw->configure(-menu => my $menubar = $mw->Menu);
my $file = $menubar->cascade(
    -label => '~ファイル', 
    -menuitems => &file_menuitems);

MainLoop;

sub file_menuitems {
    [
      '',
      ['command', '出', -command => sub {$mw->destroy}],
    ];
}
