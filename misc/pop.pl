#!/usr/bin/perl -w
use strict;

{
    my @an_array = qw(一つ 二つ 四つ 五つ 六つ 七つ 八つ 九つ 十);
    print "@an_array\n";
    print "$_\n" while ($_ = pop(@an_array));
    my $test_val = "零";
    print "$test_val\n";
    print "\$# $#an_array\n";
    $test_val = pop(@an_array);
    print "$test_val\n";
}
