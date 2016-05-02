#!/usr/bin/perl -w

use strict;
use Cwd;
use Time::Piece;
use File::Basename;
use Getopt::Std;

my ($in_path,$out_filename,$input_filename) = &test_args();
print "in path: $in_path\nout_filename: $out_filename\ninput_filename: $input_filename\n";

#&print_xml_head();

my @story_files = ();
if ( defined($input_filename) and -e $input_filename and -r _ ) {
    open (my $in_fh, "<", $input_filename) or die "Cannot open $input_filename, $!";
    chomp (@story_files = <$in_fh>);
    close($in_fh);
} else {
    @story_files = &dir_crawler($in_path);
}

&parse_files(@story_files);

#print "story files: @story_files";
#print $_ for (@story_files);

#my $the_story_files = &paths_to_file(@story_files);
#print STDERR "File names have been written to $the_story_files\n";
#&story2xml(@story_files);

#&print_xml_tail;

sub test_args {
    our %opts = ();
    my $default_out = "./output_".&get_timestamp().".txt";
    my $the_input_file = undef;

    getopts('d:f:hi:', \%opts);

    if (!%opts or $opts{"h"}) {
	&usage();
	exit(1);
    } elsif (!exists($opts{"d"}) or !defined$opts{"d"}) {
	print "-d <directory> needs to be specified\n";
	exit(1);
    }
    if (exists($opts{"i"}) and defined($opts{"i"})) {
	$the_input_file = $opts{"i"};
    }
				   
    return ($opts{"d"}, (((exists($opts{"f"}) and defined$opts{"f"})) ? $opts{"f"} : $default_out), $the_input_file);
}

sub usage {
print STDERR <<EOF;

Usage:
$0 -d <directory to explore> [-f <output filename (with path)>] [-h]
EOF
exit(1);
}

sub dir_crawler {
    my @dir = <$_[0]/*>;
    for (@dir) {
	push(@story_files,$_) if /.*\.story$/;
	&dir_crawler($_) if -d;
    }
}

sub get_timestamp {
    my @art = localtime(time);
    my $timestamp = sprintf("%4d%02d%02d_%02d%02d%02d",$art[5]+1900,++$art[4],$art[3],$art[2],$art[1],$art[0]);

    return $timestamp;
}

sub paths_to_file {
    my $fh;
    my $fm = ">";
    my $timestamp = &get_timestamp;
    my $fn = "story_files_$timestamp.txt";
    
    open($fh,$fm,$fn) or die "Cannot open $fn: $!";
    print $fh $_."\n" for (@_);
    close($fh);

    return $fn;
}

sub parse_files {
    my %file_contents = ();
    my $in_fh;
    foreach (@_) {
 	open ($in_fh, "<", $_) or die "cannot open '$_': $!";
 	$file_contents{$_} = [<$in_fh>];
 	close $in_fh;
    }
    print "$_:\n @{$file_contents{$_}}\n" for (keys %file_contents);
}

# sub story2xml {
#     my $out_filename = "story_files_with_path.txt";
#     open (my $out_fh, ">", $out_filename) or die "cannot open '$out_filename': $!";
#     my @directory_list = @_;
#     foreach (@directory_list) {
# 	open (my $fh, "<", $_) or die "cannot open '$_': $!";
# 	my @file_content = <$fh>;
# 	close $fh;

# 	print $out_fh "$_\n";
# 	$_ = basename($_);
# 	my $filename = $_;
# 	s/_/ /g;
# 	s/(\b[a-z])/\u$1/g;
# 	my $scenario_title = substr($_, 0, length($_)-length(".story"));
# 	print "<chl1><title>$scenario_title</title>\n";
# 	print "<!-- Source: $filename -->\n";

# 	my $watch_scenario = 0;
# 	my $watch_given = 0;
# 	my $watch_when = 0;
# 	my $watch_then = 0;
# 	my $watch_step_list = 0;
# 	my $watch_action = 0;
# 	my $section_title = "";

# 	for (@file_content) {
# 	    next if (/\s*#/);
# 	    chomp;
# 	    s/&/&amp;/g;
# 	    s/</&lt;/g;
# 	    if (/\s*Scenario.*:\s*\S*/) {
# 		if ($watch_given) {
# 		    $watch_given = 0;
# 		    print "</list>\n";
# 		}
# 		if (($watch_when || $watch_then) && ! $watch_action) {
# 		    $watch_when = $watch_then = 0;
# 		    print "</step-list>\n";
# 		    $watch_step_list--;
# 		}
# 		if ($watch_scenario) {
# 		    if ($watch_step_list) {
# 			print STDERR "step-list: $watch_step_list\n";
# 			$watch_when = $watch_then = 0;
# 			print "</step-list>\n";
# 			$watch_step_list--;
# 		    }
# 		    #print "</p>\n";
# 		    $watch_scenario = 0;
# 		}
# 		s/\s*Scenario.*:\s*(\S*)/$1/;
# 		print "<p>$_</p>\n";
# 		$section_title = $_;
# 		$watch_scenario++;
# 	    }

# 	    if (/\s*Given\s*\S*/) {
# 		if (($watch_when || $watch_then) && ! $watch_action) {
# 		    $watch_when = $watch_then = 0;
# 		    print "</step-list>\n";
# 		    $watch_step_list--;
# 		}
# 		unless ($watch_given) {
# 		    print "<list>\n";
# 		    print "<p><emph type=\"medium\">Preparations</emph></p>\n";
# 		}
# 		s/\s*Given\s*(\S*)/$1/;
# 		print "<list-item><p>$_</p>\n";
# 		print "</list-item>\n";
# 		$watch_given++ unless ($watch_given);
# 	    }

# 	    if ($watch_given && /\s*And appear\s*\S*/) {
# 		s/\s*And (appear)(s?)\s*(\S*)/$3/;
# 		print "<list-item><p>$1$2: <output>$_</output></p>\n";
# 		print "</list-item>\n";
# 	    }

# 	    if ($watch_given && /\s*And\s*\S*/) {
# 		s/\s*And\s*(\S*)/$1/;
# 		print "<list-item><p>$_</p>\n";
# 		print "</list-item>\n";
# 	    }

# 	    if (/\s*When\s*\S*/ && index($section_title, $_) == -1) {
# 		if ($watch_given) {
# 		    $watch_given = 0;
# 		    print "</list>\n";
# 		}
# 		if (($watch_when || $watch_then) && ! $watch_action) {
# 		    $watch_when = $watch_then = 0;
# 		    print "</step-list>\n";
# 		    $watch_step_list--;
# 		}
# 		if (! $watch_when) {
# 		    print "<step-list>\n";
# 		    $watch_step_list++;
# 		    print "<p><emph type=\"medium\">Action</emph></p>\n";
# 		    $watch_action++;
# 		}
# 		s/\s*When\s*(\S*)/$1/;
# 		print "<sl-item><p>$_</p>\n";
# 		print "</sl-item>\n";
# 	        $watch_when++ if (! $watch_when);
# 	    }

# 	    if (($watch_when || $watch_then) && /\s*And appear\s*\S*/) {
# 		s/\s*And (appear)(s?)\s*(\S*)/$3/;
# 		print "<sl-item><p>$1$2: <output>$_</output></p>\n";
# 		print "</sl-item>\n";
# 	    }

# 	    if (($watch_when || $watch_then) && /\s*And\s*\S*/) {
# 		s/\s*And\s*(\S*)/$1/;
# 		print "<sl-item><p>$_</p>\n";
# 		print "</sl-item>\n";
# 	    }

# 	    if (/\s*Then\s*\S*/) {
# 		print "<bridge><p><emph type=\"medium\">Result</emph></p>\n";
# 		$watch_action-- if ($watch_action);
# 		print "</bridge>\n";
# 		s/\s*Then\s*(\S*)/$1/;
# 		if ($watch_when) {
# 		    print "<sl-item><p>$_</p>\n";
# 		    print "</sl-item>\n";
# 		    $watch_then++;
# 		} elsif ($watch_given) {
# 		    print "<list-item><p>$_</p>\n";
# 		    print "</list-item>\n";
# 		}
# 	    }

# #	print "watch_scenario: $watch_scenario\n";
# 	}
# 	if ($watch_given) {
# 	    $watch_given = 0;
# 	    print "</list>\n";
# 	}
# 	if ($watch_when || $watch_then) {
# 	    $watch_when = $watch_then = 0;
# 	    print "</step-list>\n";
# 	    $watch_step_list--;
# 	}
# 	if ($watch_scenario) {
# 	    #print "</p>\n";
# 	    $watch_scenario = 0;
# 	}
# 	my $num_of_lines = $#file_content + 1;
# 	#print STDERR "$watch_scenario, $watch_given, $watch_when, $watch_then\n";
# 	print "<!--End of $filename ($num_of_lines lines) -->\n";
# 	print "</chl1>\n";
#     }
#     close($out_fh);
# }

# sub print_xml_head {
#     my $doc_name = "TEST SPECIFICATION";
#     my $doc_number = "152 41-APR 901 0509";
#     my $doc_rev = "PA1";
#     my $doc_date = Time::Piece->new->strftime('<y>%Y</y><m>%m</m><d>%d</d>');
#     my $doc_bunit = "BNET";
#     my $doc_compname = "Ericsson AB";
#     my $doc_title = "License Administration Tool Core Test Specification";
#     my $doc_subtitle = "";
#     my $doc_drafter = "<name>Tibor Harcsa</name><signature>etibhar</signature>";
#     my $doc_approver = "<name>András Czigány</name><signature>EANDCZI</signature>";

#     print <<EOF;
# <?xml version="1.0" encoding="UTF-8"?>
# <!--Arbortext, Inc., 1988-2008, v.4002-->
# <!DOCTYPE doc PUBLIC "-//ERICSSON//DTD XSEIF 1/FAD 110 05 R5//EN"
#  "XSEIF_R5.dtd">
# <doc version="XSEIF R5"
# xmlns="urn:x-ericsson:r2:reg-doc:1551-fad.110.05:en:*"><?Pub Caret1?>
# <meta-data><?Pub Dtl?>
# <confidentiality class="ericsson-internal"/>
# <doc-name>$doc_name</doc-name>
# <doc-id>
# <doc-no type="registration">$doc_number</doc-no><language code="en"/><rev>$doc_rev</rev>
# <date>$doc_date</date>
# </doc-id>
# <company-id>
# <business-unit>$doc_bunit</business-unit>
# <company-name>$doc_compname</company-name>
# <company-symbol logotype="ericsson"></company-symbol>
# </company-id>
# <title>$doc_title</title>
# <subtitle>$doc_subtitle</subtitle>
# <drafted-by>
# <person>
# $doc_drafter
# </person>
# </drafted-by>
# <approved-by>
# <person>
# $doc_approver
# </person>
# </approved-by>
# </meta-data>
# <front></front>
# <body>
# EOF
# }

# sub print_xml_tail {
#     print <<EOF;
# </body>
# </doc>
# EOF
# }
