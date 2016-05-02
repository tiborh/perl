#!/usr/bin/perl -w

my $test_string = "(test string)";
my $regex = qr/T.?XT/;
my @test_array = qw(one two three);

print q(q/something/ = 'something'),"\n";
print qq(qq/something/ = "something"\n);
print qq(qx/date/ = `date` (command execution)\n);
print qx/date/;
print qq(q/word list/ is equivalent to (word list)\n);
print q/@test_array = ("one","two","three")/,"\n";
print "whereas,\n";
print qq(\@test_array = qw/@test_array/\n);
print qq(/match pattern/ = m/match pattern/\n);
print qq+There's+,($test_string =~ /test/)?"":" no",q+ "test" in $test_string+,"\n";
print qq(s/test/text/ has no equivalent.\n);
print $test_string,"\n";
$test_string =~ s/test/text/;
print $test_string,"\n";
print qq(y/a-f/A-F/ = tr/a-f/A-F/\n);
$test_string =~ y/txt/TXT/;
print $test_string,"\n";
print qq(qr/s.?m.?th.?ng/ for regular expression "s.?m.?th.?ng"\n);
$test_string =~ s/$regex/test/;
print $test_string,"\n";
print "Different parentheses can also be used: s(foo)[bar]; \n";
print "line break can also be used:\ntr[a-f]\n  [A-F];\n";
