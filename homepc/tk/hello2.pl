#!/usr/bin/perl -w

use Tk;

my $mw = MainWindow->new;
$mw->title("Hello world");
my $hello_lbl = $mw->Label(
    -text => "Hello world!", 
    -height => 5,
    )->pack;
my $unpack_btn = $mw->Button(
    -text => "Unpack label", 
    -command => [sub{$hello_lbl->packForget()}], 
    -width => 20,
    )->pack;
my $exit_btn = $mw->Button(
    -text => "Done", 
    -command => [$mw => 'destroy'], 
    -width => 20,
    )->pack;
MainLoop;
