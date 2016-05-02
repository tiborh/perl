#!/usr/bin/env perl
use strict;
use warnings;
use CGI;
use CGI::Pretty;

sub cgiOut {
    my (%host) = @_;
    my $q = new CGI;
    print  $q->header( "text/plain" ),
    $q->start_html( -title=>"Apache Stats for \$hostname",
		    -bgcolor=>"#ffffff"),
    $q->h2( "Apache Stats for \$hostname" ),
    $q->hr,
    $q->table( { -border=>"1", -width=>"100%" },
	       map{
		   $q->Tr(
		       $q->td($_) ,
		       $q->td($host{$_})
		       )
	       } sort keys %host
	);
    print  $q->end_html;
}

my %host= ( foo=>100, bar=>200,, baz=>300 );

cgiOut %host;
