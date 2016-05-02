#!/usr/bin/perl -w

use strict;

my $parts = [qw/main_board ram cpu power_unit pc_case hdd optical_unit monitor video_card/];
my $configs = [qw/am3 lga775 lga1155/];
my $main_board = [qw/name socket front_side_bus ram_sockets video price/];
my $memory = [qw/name mhz type number price/];
my $cpu = [qw/name socket iclock cores l3 l2 l1 fsb boxed/];


for (@$parts) {
    print "$_\n";
}
