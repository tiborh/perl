#!/usr/bin/perl -w
use strict;
#use utf8;
#binmode STDOUT, ":utf8";

use CGI;
# this image can also be placed as an img tag on an html page.
my $cgi = new CGI;

my $data;
{
    my $fn = "/var/www/img/flag.gif";
    my $fh;
    open($fh,"<",$fn) or die "Cannot read $fn, $!";
    my $size = -s $fn;
    #print "Size of the image: $size\n";
    
    read $fh, $data, $size;
    close($fh);
}
print $cgi->header(-type=>'image/gif'), $data;

{
#site logger
    my %logger = ();
    $logger{Time}=time;
    $logger{Query} = $ENV{QUERY_STRING};
    $logger{Referer} = $ENV{HTTP_REFERER};
    $logger{IP} = $ENV{REMOTE_ADDR};
    $logger{Host} = $ENV{REMOTE_HOST};
    $logger{UserAgent} = $ENV{HTTP_USER_AGENT};

    my $fh;
    my $fn = "log.txt";
    open($fh,">>",$fn) or die "Cannot open $fn, $!";
    flock($fh,2);
    my $line = "";
    $line .= "$logger{$_}|" foreach (sort keys %logger);
    $line =~ s/\|$/\n/;
    print $fh $line;
    close($fh);
}

exit;
