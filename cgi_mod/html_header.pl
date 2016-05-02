#!/usr/bin/env perl

use warnings;
use v5.14; 			# implies strict
use Carp;
use utf8;
use autodie;
#the following two needs installation:
#use Modern::Perl;
#use Test::More;

binmode(STDOUT, ":utf8");

use CGI;
use html;

my $q = CGI->new();
say $q->header(-type => 'text/html', -charset => 'utf-8'),
    $q->start_html(-title=>'Secrets of the Pyramids',
		   -author=>'fred@capricorn.org',
		   -base=>'true',
		   -target=>'_blank',
		   -meta=>{'keywords'=>'pharaoh secret mummy',
			   'copyright'=>'copyright 1996 King Tut'},
		   -style=>{'src'=>'/styles/style1.css'},
		   -bgcolor=>'blue');
say $q->p("始めまして。");
&MyHtml::printcode($0,$q);
say $q->end_html; 

