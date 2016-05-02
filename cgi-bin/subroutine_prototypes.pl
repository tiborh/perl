#!/usr/bin/perl -w
use strict;
use utf8;
binmode STDOUT, ":utf8";

my $title = "Subroutine Prototypes";

sub main {
    print <<EOT;
<h1>$title</h1>
<p>Subroutine prototypes tell the subroutine how many arguments to expect and what type.</p>
<p>When different number or types of input are received, the script execution stops with an error message.</p>
<p>Optional arguments can also be given, after a semicolon.</p>
EOT

my $input_txt = "some text";
    my $input2_txt = "SOME TEXT";
    my @strings = qw(TV Radio web);
    my $num = 3;
    print "<p>input1: $input_txt<br />\n";
    print "output1: ",&doit($input_txt),"</p>\n";

    print "<p>input2: $input_txt and $input2_txt<br />\n";
    print "output2: ",&doit2($input_txt,$input2_txt),"</p>\n";

    print "<p>input3: $input_txt<br />\n";
    print "output3: ",&doit3($input_txt),"</p>\n";

    print "<p>input4: @strings<br />\n";
    print "output4: ",&doit4(@strings),"</p>\n";

    print "<p>input5: $num, @strings<br />\n";
    print "output5: ",&doit5($num,@strings),"</p>\n";


sub doit($) {
    my $string = shift;
    return uc($string);
}

sub doit2($$) {
    my $string = shift;
    my $string2 = shift;
    return uc($string),' ',lc($string2);
}

# optional second argument
sub doit3($;$) {		# there will be some complaint, but no error if second argument is not found
    my ($string,$string2) = @_;
    return uc($string),' ',lc($string2);
}

sub doit4(@) {
    my ($var1, $var2, $var3) = @_;
    $var1 = lc($var1);
    $var2 = uc($var2);
    $var3 = uc($var3);
    return $var1, ' ',$var2, ' ',$var3;
}

sub doit5($@) {
    my ($num, $var1, $var2, $var3) = @_;

    return "$var1 $var2 $var3 " x $num;
}



} # main

require "html.cgi";

&cgi_head("$title");
&main();
&printcode($0);
&cgi_foot();
exit;
