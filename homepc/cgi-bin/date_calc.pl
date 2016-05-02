#!/usr/bin/perl -w
use strict;
use utf8;
binmode STDOUT, ":utf8";

my $title = "Date Calculations";

sub main {
    print <<EOT;
<h1>$title</h1>
<p>There are lots of date calculation functions in the module <code>Date:Calc</code>. Parts of it or the whole can be invoked.</p>
EOT

    {
	use Date::Calc qw(:all); # not part of standard Perl

	my $year = 2012;
	my $month = 6;
	my $days = Days_in_Year($year,$month); # up until the month
	print "<p>Number of days in year $year up to the end of month $month: <code>$days</code></p>\n";
	my $leap = leap_year($year);
	print "<p>Year $year is ", $leap ? "\b" : "not", " a leap year.</p>\n";
	{
	    $year = 2014;
	    $leap = leap_year($year);
	    print "<p>Year $year is ", $leap ? "\b" : "not", " a leap year.</p>\n";
	}
	my $hour = 12;
	my $min = 59;
	my $sec = 59;
	my $checktime = check_time($hour,$min,$sec);
	print ("<p>The data <code>$hour:$min:$sec</code> represents " , $checktime ? "valid" : "invalid" , " time</p>\n");
	{
	    $sec = 60;
	    $checktime = check_time($hour,$min,$sec);
	print ("<p>The data <code>$hour:$min:$sec</code> represents " , $checktime ? "valid" : "invalid" , " time</p>\n");
	}
	my $day = 15;
	{
	    $month = 1;
	    my $week = Week_Number($year,$month,$day);
	    print "<p>The date $year-$month-$day is on week $week.</p>\n";
	}
	my $datetotext = Date_to_Text_Long($year,$month,$day);
	print "<p>The long date format: <code>$datetotext</code></p>\n";
	my $calendar = Calendar($year,$month);
	print "<pre>";
	print "$calendar";	
	print "</pre>\n";

	my $monthToText = Month_to_Text($month);
	print "<p>The month ($month) converted to text: $monthToText</p>\n";

	{
	    my $year2 = 2015;
	    my $month2 = 1;
	    my $day2 = 21;
	    my $deltaDays = Delta_Days($year,$month,$day,$year2,$month2,$day2);
	    print "The difference between dates $year-$month-$day and $year2-$month2-$day2: $deltaDays days.</p>\n";
	}
    }

}

require "html.cgi";

&cgi_head("$title");
&main();
&printcode($0);
&cgi_foot();
exit;
