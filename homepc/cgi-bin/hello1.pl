#!/usr/bin/env perl

use warnings;
use v5.14; 			# implies strict
use Carp;
use utf8;
use autodie;

binmode(STDOUT, ":utf8");

use CGI;                             # load CGI routines
use html;
my $msg = 'hello world';
my $q = CGI->new;                        # create new CGI object
say $q->header(-type => 'text/html', -charset => 'utf-8'),                    # create the HTTP header (default encoding is iso8859-1
    $q->start_html(-title=>$msg,-encoding=>'utf-8'), # start the HTML (default encoding is iso8859-1
    $q->h1({-style=>'text-align: center'},$msg);         # level 1 header
say $q->p("始めまして。");	# to test utf8
&MyHtml::printcode($0,$q);
say $q->end_html;                  # end the HTML

# possible parameters of start_html
    # my($title,$author,$base,$xbase,$script,$noscript,
    #     $target,$meta,$head,$style,$dtd,$lang,$encoding,$declare_xml,@other) = 
    # 	rearrange([TITLE,AUTHOR,BASE,XBASE,SCRIPT,NOSCRIPT,TARGET,
    #                META,HEAD,STYLE,DTD,LANG,ENCODING,DECLARE_XML],@p);
