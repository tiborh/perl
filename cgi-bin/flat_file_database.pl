#!/usr/bin/perl -w
use strict;
use utf8;
binmode STDOUT, ":utf8";

sub main {
    print <<EOT;
<h1>Flat file database</h1>
<p></p>
EOT
    {
	my $fh;
	my $fn = "data.txt";
	open($fh,"<",$fn) or die "Cannot open $fn, $!";
	my @data = <$fh>;
	shift(@data);
	
	print "<h2>Countries of the world</h1>\n";
	my $OldContinent = "";
	foreach (@data) {
	    chomp;
	    my @tmp_data = split(/\t/,$_);
	    if ($OldContinent ne $tmp_data[0]) {
		print "<p><br /><b>$tmp_data[0]</b></p>";
		$OldContinent = $tmp_data[0];
	    }
	    print "<p>$tmp_data[2] ($tmp_data[4])</p>\n";
	}
    }
}

require "html.cgi";

&cgi_head("flat file database");
&main();
&printcode($0);
&cgi_foot();
exit;
