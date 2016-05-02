#!/usr/bin/perl

@arr_samp = (["spring (春)","summer （夏）","autumn （秋）","winter （冬）"],
	    ["March （三月）","June （六月）","September （九月）","December （十二月）"],
	    ["April （四月）","July （七月）","October （十月）","January （一月）"],
	    ["May （五月）","August （八月）","November （十一月）","February （二月）"]);

for ($i=0; $i<4; $i++)
{
    for ($j=0; $j<4; $j++)
    {
	($j > 0)?print "\t": print " ";
	print $arr_samp[$j][$i], "\n";
    }
}
