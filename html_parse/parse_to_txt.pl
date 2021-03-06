#!/usr/bin/perl -w

use strict;
#use utf8;
#binmode STDOUT, ":utf8";

  {
      #use LWP::Simple;
      use HTML::TreeBuilder;
      use HTML::FormatText;
      
      my $file_content = "";
      $file_content .= $_ while (<>);
      #print STDERR "the content:\n";
      #print $file_content;
      my $Format = HTML::FormatText->new(leftmargin => 3, rightmargin => 50);
      my $TreeBuilder = HTML::TreeBuilder->new;
      $TreeBuilder->parse($file_content);
      my %html_tree = %$TreeBuilder;
      my $Parsed = $Format->format($TreeBuilder);

      print $Parsed;
  }
