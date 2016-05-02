#!/usr/bin/perl -w
use strict;
use utf8;
binmode STDOUT, ":utf8";

my $title = "Subroutines and references";

sub main {
    print <<EOT;
<h1>$title</h1>
<p>If we try to return two arrays from a subroutine, they are merged.</p>
<p>The same is true when passing two arrays to a subroutine.</p>
EOT

my @array = &twoarrays;
print "<p>The return value of a subroutine: @array</p>\n";


sub twoarrays {
    my @x = (1..10);
    my @y = (11..20);
    return @x, @y;
}

sub twoarrays2 {
    my @x = (1..10);
    my @y = (11..20);
    return \@x, \@y;
}

my ($xref, $yref) = twoarrays2;

print <<EOT;
<p>If we want to preserve them separately, (array) references are returned.<br />
The first returned array: @$xref<br />
The second returned array: @$yref</p>
EOT

    my @a = (1..5);
my @b = (6..10);

sub addup {
    my (@a, @b) = @_;
    my @sum = ();
    printf("The length of the input array: %d",$#_+1);
    unshift(@sum, pop(@a) + pop(@b)) while(@a);
    return @sum;
}

print <<EOT;
<p>When passing two arrays (a = @a, b = @b) to the subroutine, the following happens:<br />
EOT

    my @c = addup(@a,@b);
print "<br />\n";
print "And the returned array: @c</p>\n";

sub addup2 {
    my ($refa, $refb) = @_;
    my @sum = ();
    printf("The length of the input array: %d",$#_+1);
    unshift(@sum, pop(@a) + pop(@b)) while(@a);
    return @sum;
}

print <<EOT;
<p>When passing two array references to the subroutine, the following happens:<br />
EOT

    @c = addup2(\@a,\@b);
print "<br />\n";
print "And the returned array: @c</p>\n";



}

require "html.cgi";

&cgi_head("$title");
&main();
&printcode($0);
&cgi_foot();
exit;
