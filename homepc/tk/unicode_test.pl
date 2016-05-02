#!/usr/bin/perl -w
use warnings;
use strict;
use Tk;
use utf8;
use encoding 'utf8';
use Encode qw(encode decode);

my $mw = tkinit;

my $menubar = $mw->Menu(-type => 'menubar');
$mw->configure(-menu => $menubar);

my $text1 =  encode( 'utf8','ファイル'); # file
my $text2 =  encode( 'utf8','オープン'); # open
my $text3 =  encode( 'utf8','セーブ'); # save
my $text4 =  encode( 'utf8','終了'); # exit

my $menu = $menubar->cascade(-label => $text1);
$menu->command(-label => $text2);
$menu->command(-label => $text3);
$menu->separator();
$menu->command(
    -label => $text4,
    -command => sub{
	print "終了為る（しゅうりょうする）\n";
	$mw->destroy;
    }
    );

MainLoop;
__END__ 
