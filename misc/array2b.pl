#!/usr/bin/perl -w

@arr_samp = (["Spring (春)","March （三月）","April （四月）","May （五月）"],
	    ["Summer （夏）","June （六月）","July （七月）","August （八月）"],
	    ["Autumn （秋）","September （九月）","October （十月）","November （十一月）"],
	    ["Winter （冬）","December （十二月）","January （一月）","February （二月）"]);

foreach $xrows (@arr_samp) {
    for(my $i=0;$i<@$xrows;$i++) {
	print(($i == 0) ? "" : "\t");
#	print "${$xrows}[$i]\n";
	print "$$xrows[$i]\n";
#	print "$xrows->[$i]\n";
    }
}
