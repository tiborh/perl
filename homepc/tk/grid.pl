#!/usr/bin/perl -w

use Tk;
use utf8;

binmode STDOUT, 'encoding(UTF-8)';

# Main Window
my $mw = MainWindow->new;
$mw->title("Grid demo");

$mw->Button(-text => '零', -command => sub{print "０\n"})->grid(
    $mw->Button(-text => '一', -command => sub{print "１\n"}),
    $mw->Button(-text => '二', -command => sub{print "２\n"}),
    $mw->Button(-text => '三', -command => sub{print "３\n"}),
    -sticky => "nsew");
$mw->Button(-text => '四', -command => sub{print "４\n"})->grid(
    $mw->Button(-text => '五', -command => sub{print "５\n"}),
    $mw->Button(-text => '六', -command => sub{print "６\n"}),
    $mw->Button(-text => '出', -command => \&call4),
    -sticky => "nsew");
$mw->Button(-text => '七', -command => sub{print "７\n"})->grid(
    $mw->Button(-text => '八', -command => sub{print "８\n"}),
    $mw->Button(-text => '九', -command => sub{print "９\n"}),
    "^", -sticky => "nsew");
$mw->Button(-text => '十', -command => sub{print "１０\n"})->grid(
    $mw->Button(-text => '百', -command => sub{print "１００\n"}),
    $mw->Button(-text => '千', -command => sub{print "１０００\n"}),
    $mw->Button(-text => '万', -command => sub{print "１００００\n"}),
    -sticky => "nsew");


MainLoop;

sub call4{exit;}
