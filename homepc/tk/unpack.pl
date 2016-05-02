#!/usr/bin/perl -w

use Tk;
use utf8;

my $mw = MainWindow->new;
my $show_label_btn;
$mw->title("Hello world");
my $hello_lbl = $mw->Label(
    -text => "Hello world!", 
    -height => 5,
    )->pack;
my $unpack_btn = $mw->Button(
    -text => "Unpack label", 
    -command => [\&hide_label], 
    -width => 20,
    )->pack;
my $exit_btn = $mw->Button(
    -text => "Done", 
    -command => [$mw => 'destroy'], # in a sub it would be $mw->destroy
    -width => 20,
    )->pack;

MainLoop;

sub hide_label() {
    $hello_lbl->packForget();
    if (! Exists($show_label_btn)) {
	$show_label_btn = $mw->Button(
	-text => "Pack label", 
	-command => [\&show_label], 
	-width => 20,
	)->pack;
    } else {
	$show_label_btn->pack;
    }
    if (Exists($unpack_btn)) {
	$unpack_btn->packForget();
    }
}

sub show_label() {
    $exit_btn->packForget();
    $hello_lbl->configure(-text => "今日は！");
    $hello_lbl->pack();
    if (Exists($show_label_btn)) {
	$show_label_btn->packForget();
    }
    $unpack_btn->pack;
    $exit_btn->pack;
}
