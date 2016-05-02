#!/usr/bin/env perl

local ($buffer, @pairs, $pair, $name, $value, %FORM);
# Read in text
$ENV{'REQUEST_METHOD'} =~ tr/a-z/A-Z/;
if ($ENV{'REQUEST_METHOD'} eq "GET")
{
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
$first_name = $FORM{first_name};
$last_name  = $FORM{last_name};

print "Content-type:text/html\r\n\r\n";
print '<html>',"\n";
print '<head>',"\n";
print "\t",'<meta http-equiv="Content-Type" content="text/html" charset="utf-8" />',"\n";
print "\t",'<title>Processing Get Methods</title>',"\n";
print '</head>',"\n";
print '<body>',"\n";
print "\t",'<h1>今日は！</h1>',"\n";
print "\t","<h2>Hello $first_name $last_name!</h2>\n";
print '</body>',"\n";
print '</html>',"\n";

1;
