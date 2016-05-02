#!/usr/bin/perl

%theYear = (
    "Spring (春)" => "March （三月）;April （四月）;May （五月）",
    "Summer （夏）" => "June （六月）;July （七月）;August （八月）",
    "Autumn （秋）" => "September （九月）;October （十月）;November （十一月）",
    "Winter （冬）" => "December （十二月）;January （一月）;February （二月）",
);

$maxi = scalar keys %theYear;
print "Number of seasons: $maxi\n";

foreach $theSeasons (keys %theYear) {
    print $theSeasons,"\n";
    @theMonths = split(";",$theYear{$theSeasons});
    foreach $aMonth (@theMonths) {
	printf("\t%s\n",$aMonth);
    }
}
