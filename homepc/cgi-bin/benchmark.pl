#!/usr/bin/perl -w
use strict;
use utf8;
binmode STDOUT, ":utf8";

sub main {
    print <<EOT;
<h1>Benchmark</h1>
<p>Benchmarking code with the <code>Benchmark</code> module.</p>
<h2>Benchmarking running time</h2>
EOT

    {
	use Benchmark ':hireswallclock';

	my $start = new Benchmark;

	my $count = 50000000;
	$count-- while ($count > 0);

	my $finish = new Benchmark;

	my $TimeDiff = timediff($start,$finish);

	print "<p>Loop Time: ", timestr($TimeDiff) . "</p>\n\n";
    }

    {
	print "<h2>Benchmarking performance during set time interval</h2>\n";
	print "<pre>";
	timethis(
	    -5, '
	     my $count = 1000; 
             $count-- while ($count > 0);
	    ');
	print "</pre>\n\n";
    }

    {
	print "<h2>Benchmarking methods</h2>\n";
	print "<pre>";
	timethese(20000000, {
	    'method1' => 'my $sum = 1 + 1;',
	    'method2' => 'my $sum = 1 * 2;',
	    'method3' => 'my $sum = 1000 / 500;'
		  }); print "</pre>\n\n";
    }

    {
	use Benchmark qw(:all);

	print "<h2>Benchmarking methods with compare</h2>\n";
	print "<pre>";
	cmpthese(20000000, {
	    'method1' => 'my $sum = 1 + 1;',
	    'method2' => 'my $sum = 1 * 2;',
	    'method3' => 'my $sum = 1000 / 500;'
		  }); print "</pre>\n\n";

    }
}



require "html.cgi";

&cgi_head("benchmarking the code");
&main();
&printcode($0);
&cgi_foot();
exit;
