#!/usr/bin/perl -w

use strict;
use Cwd;
use Time::Piece;

if ($#ARGV < 0) {
    printf("you need a directory name as argument\n");
    exit(1);
} else {
    chdir $ARGV[0] || die "cannot cd to '$ARGV[0]' ($!)";
}

my $pwd = getcwd;
my @directory_list = <$pwd/*>;
#print "$_\n" for (@directory_list);

&print_xml_head();

foreach (@directory_list) {
    open (my $fh, "<", $_) or die "cannot open '$_': $!";
    my @file_content = <$fh>;
    close $fh;

    my $filename = substr($_, length($pwd)+1);
    s/([a-z])([A-Z])/$1 $2/g;
    my $scenario_title = substr($_, length($pwd)+1, length($_)-length($pwd)-1-length(".feature"));
    print "<chl1><title>$scenario_title</title>\n";
    print "<!-- Source: $filename -->\n";

    my $watch_scenario = 0;
    my $watch_given = 0;
    my $watch_when = 0;
    my $watch_then = 0;
    my $watch_step_list = 0;

    for (@file_content) {
	next if (/\s*#/);
	chomp;
	s/&/&amp;/g;
	s/</&lt;/g;
	if (/\s*Scenario.*:\s*\S*/) {
	    if ($watch_given) {
		$watch_given = 0;
		print "</list>\n";
	    }
	    if ($watch_when || $watch_then) {
		$watch_when = $watch_then = 0;
		print "</step-list>\n";
		$watch_step_list--;
	    }
	    if ($watch_scenario) {
		if ($watch_step_list) {
		    print STDERR "step-list: $watch_step_list\n";
		}
		print "</chl2>\n";
		$watch_scenario = 0;
	    }
	    s/\s*Scenario.*:\s*(\S*)/$1/;
	    print "<chl2><title>$_</title>\n";
	    $watch_scenario++;
	}

	if (/\s*Given\s*\S*/) {
	    unless ($watch_given) {
		print "<list>\n";
		print "<p><emph type=\"medium\">Preparations</emph></p>\n";
	    }
	    s/\s*Given\s*(\S*)/$1/;
	    print "<list-item><p>$_</p>\n";
	    print "</list-item>\n";
	    $watch_given++ unless ($watch_given);
	}

	if ($watch_given && /\s*And\s*\S*/) {
	    s/\s*And\s*(\S*)/$1/;
	    print "<list-item><p>$_</p>\n";
	    print "</list-item>\n";
	}

	if (/\s*When\s*\S*/) {
	    if ($watch_given) {
		$watch_given = 0;
		print "</list>\n";
	    }
	    if ($watch_when || $watch_then) {
		$watch_when = $watch_then = 0;
		print "</step-list>\n";
		$watch_step_list--;
	    }
	    print "<step-list>\n";
	    $watch_step_list++;
	    print "<p><emph type=\"medium\">Action</emph></p>\n";
	    s/\s*When\s*(\S*)/$1/;
	    print "<sl-item><p>$_</p>\n";
	    print "</sl-item>\n";
	    $watch_when++;
	}

	if (($watch_when || $watch_then) && /\s*And\s*\S*/) {
	    s/\s*And\s*(\S*)/$1/;
	    print "<sl-item><p>$_</p>\n";
	    print "</sl-item>\n";
	}

	if (/\s*Then\s*\S*/) {
	    print "<bridge><p><emph type=\"medium\">Result</emph></p>\n";
	    print "</bridge>\n";
	    s/\s*Then\s*(\S*)/$1/;
	    if ($watch_when) {
		print "<sl-item><p>$_</p>\n";
		print "</sl-item>\n";
		$watch_then++;
	    } elsif ($watch_given) {
		print "<list-item><p>$_</p>\n";
		print "</list-item>\n";
	    }
	}

#	print "watch_scenario: $watch_scenario\n";
    }
    if ($watch_given) {
	$watch_given = 0;
	print "</list>\n";
    }
    if ($watch_when || $watch_then) {
	$watch_when = $watch_then = 0;
	print "</step-list>\n";
	$watch_step_list--;
    }
    if ($watch_scenario) {
	print "</chl2>\n";
	$watch_scenario = 0;
    }
    my $num_of_lines = $#file_content + 1;
    #print STDERR "$watch_scenario, $watch_given, $watch_when, $watch_then\n";
    print "<!--End of $filename ($num_of_lines lines) -->\n";
    print "</chl1>\n";
}

&print_xml_tail;

sub print_xml_head {
    my $doc_name = "DEMO PROCEDURE";
    my $doc_number = "1/155 52-CNA 403 2428";
    my $doc_rev = "PA1";
    my $doc_date = Time::Piece->new->strftime('<y>%Y</y><m>%m</m><d>%d</d>');
    my $doc_bunit = "BNET";
    my $doc_compname = "Ericsson AB";
    my $doc_title = "GAT for SHM Project in OSS-RC";
    my $doc_subtitle = "Software and Hardware Manager (FAJ 121 2046)";
    my $doc_drafter = "<name>Tibor Harcsa</name><signature>etibhar</signature>";
    my $doc_approver = "<name>Suresh Ganta </name><signature>XCSSUGA</signature>";

    print <<EOF;
<?xml version="1.0" encoding="UTF-8"?>
<!--Arbortext, Inc., 1988-2008, v.4002-->
<!DOCTYPE doc PUBLIC "-//ERICSSON//DTD XSEIF 1/FAD 110 05 R5//EN"
 "XSEIF_R5.dtd">
<doc version="XSEIF R5"
xmlns="urn:x-ericsson:r2:reg-doc:1551-fad.110.05:en:*"><?Pub Caret1?>
<meta-data><?Pub Dtl?>
<confidentiality class="ericsson-internal"/>
<doc-name>$doc_name</doc-name>
<doc-id>
<doc-no type="registration">$doc_number</doc-no><language code="en"/><rev>$doc_rev</rev>
<date>$doc_date</date>
</doc-id>
<company-id>
<business-unit>$doc_bunit</business-unit>
<company-name>$doc_compname</company-name>
<company-symbol logotype="ericsson"></company-symbol>
</company-id>
<title>$doc_title</title>
<subtitle>$doc_subtitle</subtitle>
<drafted-by>
<person>
$doc_drafter
</person>
</drafted-by>
<approved-by>
<person>
$doc_approver
</person>
</approved-by>
</meta-data>
<front></front>
<body>
EOF
}

sub print_xml_tail {
    print <<EOF;
</body>
</doc>
EOF
}
