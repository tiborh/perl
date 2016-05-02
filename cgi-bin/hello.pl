#!/usr/bin/env perl

use warnings;
use v5.14; 			# implies strict
use Carp;
use utf8;
use autodie;

binmode(STDOUT, ":utf8");

use CGI;                             # load CGI routines
use html;
my $q = CGI->new;                        # create new CGI object
say $q->header,                    # create the HTTP header
    $q->start_html('hello world'), # start the HTML
    $q->h1('hello world');         # level 1 header
&MyHtml::printcode($0,$q);
say $q->end_html;                  # end the HTML
