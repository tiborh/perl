#!/usr/bin/perl -w

use Tk;
use utf8;

my $kanjiFont_small = "Helvetica -18";
my $mw = MainWindow->new;
$mw->title("今晩は！");
$mw->Label(
    -text => "今晩は\n（こんばんは）",
    -font => $kanjiFont_small,
    -height => 5,
    )->pack;
$mw->Button(-text => "Info", -command => \&give_info, -width => 20)->pack;
$mw->Button(-text => "Done", -command => sub{exit}, -width => 20)->pack;
MainLoop;

sub give_info {
    
}
