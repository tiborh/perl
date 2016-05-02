#!/usr/bin/perl -w

use strict;
use utf8;
use encoding 'utf8';

my %kanji_data = (
    日 => {
	音 => [qw(ニチ ジツ)],
	訓 => [qw(ひ ーび ーか)],
    },
    木 => {
	音 => [qw(ボク モク)],
	訓 => [qw(き ーこ)],
    },
    本 => {
	音 => [qw(ホン)],
	訓 => [qw(もと)],
    },
    未 => {
	音 => [qw(ミ)],
	訓 => [qw(ま·だ)],
    },
    末 => {
	音 => [qw(マツ バツ)],
	訓 => [qw(すえ)],
    },
    );


#print "$kanji_data{日}{音}[0]\n";
#print "@{$kanji_data{日}{音}}\n";

foreach my $key (sort keys %kanji_data) {
    print "$key\n";
}
