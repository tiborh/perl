#!/usr/bin/env perl

    local ($buffer, @pairs, $pair, $name, $value, %FORM);
    # Read in text
    $ENV{'REQUEST_METHOD'} =~ tr/a-z/A-Z/;
    if ($ENV{'REQUEST_METHOD'} eq "POST")
    {
        read(STDIN, $buffer, $ENV{'CONTENT_LENGTH'});
    }else {
	$buffer = $ENV{'QUERY_STRING'};
    }
    # Split information into name/value pairs
    @pairs = split(/&/, $buffer);
    foreach $pair (@pairs)
    {
	($name, $value) = split(/=/, $pair);
	$value =~ tr/+/ /;
	$value =~ s/%(..)/pack("C", hex($1))/eg;
	$FORM{$name} = $value;
    }
    $subject = $FORM{dropdown};

print "Content-type:text/html\r\n\r\n";
print "<html>\n";
print "<head>\n";
print "\t<title>Dropdown Box - Sixth CGI Program</title>\n";
print "</head>\n";
print "<body>\n";
print "\t<h2> Selected Subject is $subject</h2>\n";
print "</body>\n";
print "</html>\n";

1;
