#!/usr/bin/perl -w

@arr_samp = (["spring (春)","March （三月）","April （四月）","May （五月）"],
	    ["summer （夏）","June （六月）","July （七月）","August （八月）"],
	    ["autumn （秋）","September （九月）","October （十月）","November （十一月）"],
	    ["winter （冬）","December （十二月）","January （一月）","February （二月）"]);

foreach $xrows (@arr_samp) {
    foreach $yrows (@$xrows) {
	print((substr($yrows,0,1) =~ /[A-Z]/) ? "\t" : " ");
	print "$yrows\n";
    }
}
