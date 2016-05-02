#!/usr/bin/perl -w
use strict;
#use utf8;
#binmode STDOUT, ":utf8";

my $DEBUG = 0;

  {
      #use LWP::Simple;
      use HTML::TreeBuilder;
      #use HTML::FormatText;
      
      my $file_content = "";
      $file_content .= $_ while (<>);
      my $TreeBuilder = HTML::TreeBuilder->new;
      $TreeBuilder->parse($file_content);
      my %html_tree = %$TreeBuilder;

      if ($DEBUG == 9) {
	  foreach (keys %html_tree) {
	      printf("%s:\n\t %s\n",$_,defined($html_tree{$_}) ? $html_tree{$_} : "undef");
	  }
	  print "\n" x 5;

	  print "ref() of TreeBuilder: '",ref($TreeBuilder),"'\n";
	  print "_head:\t",$html_tree{"_head"},"\n";
	  print "_head->_tag: ",$html_tree{"_head"}{"_tag"},"\n";
	  print "ref() of _head: '",ref($html_tree{_head}),"'\n";
      }
      print '<!doctype html>',"\n";
      print "<html lang=\"en\">\n";
      &html_parser($html_tree{_head});
      &html_parser($html_tree{_body});
      print "</html>\n";

  }

sub html_parser() {
    die "html_parser() input ($_[0]) is not of the correct type" unless (ref($_[0]) eq 'HTML::Element');
    my $the_element = shift;
    my %no_close_tag = qw(
meta 1
link 1
);
    my %omit_tags = qw(
meta 1
);
    print STDERR "the_element in parser: ",$the_element,"\n" if ($DEBUG == 9);
    my %element_hash = %$the_element;

    if ($DEBUG == 9) {
	print STDERR "element_hash in parser:\n";
	print STDERR "\t$_\n" foreach (keys %element_hash);
    }

    if ($DEBUG == 9) {
	print STDERR "the_element values in parser: ",$the_element,"\n";
	print STDERR "\t$_ => $element_hash{$_}\n" foreach (keys %element_hash);
    }

    print "<$element_hash{_tag}";
    # foreach (keys %element_hash) {
    # 	print " $_=\"$element_hash{$_}\"" unless (/_.*/);
    # }
    print "/" if (exists($no_close_tag{$element_hash{_tag}}));
    print ">";
    print "\n" if (exists($no_close_tag{$element_hash{_tag}}));
    print STDERR "_content: $element_hash{_content}>\n" if ($DEBUG == 9);
    if (ref($element_hash{_content}) =~ /ARRAY/) {
	#print("-> Array found: @{$element_hash{_content}} (ref: ",ref(@{$element_hash{_content}}),")\n");
	foreach (@{$element_hash{_content}}) {
	    print unless (ref($_));
	    print STDERR "$_\n" if ($DEBUG == 8);
	    &html_parser($_) if (ref($_) eq 'HTML::Element');
	}
    } else {
	print STDERR "->not hash: " if ($DEBUG == 9);
	if (exists($element_hash{_content})) {
	    if (defined($element_hash{_content})) {
		print $element_hash{_content},"\n";
	    } else {
		print STDERR "The element exists but has no value.\n";
	    }
	} else {
	    print STDERR "End element: No contentt.\n" if ($DEBUG == 9);
	}
    }
    print "</$element_hash{_tag}>\n" unless (exists($no_close_tag{$element_hash{_tag}}));
}
