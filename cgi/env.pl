#!/usr/bin/env perl

print "Content-type:text/html\r\n\r\n";
print '<html>',"\n";
print '<head>',"\n";
print "\t",'<meta http-equiv="Content-Type" content="text/html" charset="utf-8" />',"\n";
print "\t",'<title>Environment</title>',"\n";
print '</head>',"\n";
print '<body>',"\n";
print "\t",'<h1>Environment</h1>',"\n";
print '<ol>',"\n";
foreach (sort keys %ENV)
{
  print "\t<li><b>$_</b>: $ENV{$_}</li>\n";
}
print '</ol>',"\n";

print '</body>',"\n";
print '</html>',"\n";

1;
