#!/usr/bin/perl -w
# file tl.pl
use Tk;
use strict;

my $tl;
my $mw = MainWindow->new;
$mw->title('File preview');
my $button = $mw->Button(-text => 'Help',
                         -command => \&do_top);
my $exit = $mw->Button(-text => 'Exit',
                       -command => [$mw => 'destroy']);
$button->pack;
$exit->pack;
MainLoop;

sub do_top {
  if (! Exists($tl)) {
    $tl = $mw->Toplevel;
    $tl->title('Help');
    $tl->Button(-text => 'Close',
                -command => sub {$tl->withdraw })->pack;
  }
  else {
    $tl->deiconify;
    $tl->raise;
  }
}
