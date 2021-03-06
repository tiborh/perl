#!/usr/bin/perl -w

use strict;
use Cwd;
use Time::Piece;
use File::Basename;
use Getopt::Std;

 my ($in_path,$out_filename,$input_filename,$story_filename) = &test_args();
 if ($in_path == -1 && $input_filename == -1) {
     print "No valid input has been given. Either -d or -i should be valid.\n";
     exit 1;
 }

print STDERR "in path: $in_path\nout_filename: $out_filename\n";

if ($in_path != -1) {
    if (substr($in_path,-1) eq '/') {
	substr($in_path,-1,1,"");
	#print STDERR $in_path."\n";
    }
}

#&print_xml_head();

my @story_files = ();
if ( defined($input_filename) and -e $input_filename and -r _ ) {
    print STDERR "input_filename: $input_filename\n";
    open (my $in_fh, "<", $input_filename) or die "Cannot open $input_filename, $!";
    chomp (@story_files = <$in_fh>);
    close($in_fh);
} else {
    &dir_crawler($in_path);
}

&paths_to_file($story_filename,@story_files);

my %structure_hash = &collect_in_hash(@story_files);

#print STDERR %structure_hash;

&parse_files(\%structure_hash,\@story_files,$out_filename);

#print STDERR "story files: @story_files";
#print STDERR $_ for (@story_files);


#&story2xml(@story_files);

#&print_xml_tail;

sub test_args {
    our %opts = ();
    my $the_input_file = -1;
    my $input_dir_path = -1;
    my $story_file_out = -1;
    my $default_out = -1;

    getopts('d:hi:o:s:', \%opts);

    if (!%opts or $opts{"h"}) {
	&usage();
	exit(1);
    } elsif (exists($opts{"i"})) {
	if (!defined($opts{"i"})) {
	    print STDERR "-i: a filename needs to be specified.\n";
	    exit(1);
	} elsif (! -e $opts{"i"}) {
		print STDERR "-i: the name of an existing file is needed.\n";
		exit(1);
	} else {
		$the_input_file = $opts{"i"};
	}
    } elsif (!exists($opts{"d"}) or !defined($opts{"d"})) {
	print STDERR "-d <directory> needs to be specified\n";
	exit(1);
    } elsif (-e $opts{"d"} and -d $opts{"d"}) {
	$input_dir_path = $opts{"d"};
    } else {
	print "-d <input directory>: needs to be a valid directory\n";
	exit(1);
    }

    if (exists($opts{"s"})) {
	if (defined($opts{"s"})) {
	    $story_file_out = $opts{"s"};
	} else {
	    $story_file_out = "story_files_".&get_timestamp().".txt";
	}
    }
    
    if (exists($opts{"o"})) {
	if (defined($opts{"o"})) {
	    $default_out = $opts{"o"};
	} else {
	    $default_out = "./output_".&get_timestamp().".xml";
	}
    }
				   
    return ($input_dir_path, $default_out, $the_input_file, $story_file_out);
}

sub usage {
print STDERR <<EOF;

Usage:
$0 -d <directory to explore> [-h] [-o [<output filename (with path)>]] [-s [<name of txt file for story file paths>]]
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
    my $fn = shift @_;
    return if ($fn eq "-1");
    open($fh,$fm,$fn) or die "Cannot open $fn: $!";
    print $fh $_."\n" for (@_);
    close($fh);

    print STDERR "File names have been written to $fn\n";
}

sub collect_in_hash() {
    my @collect_list = @_;
    my %collect_hash = ();

    $collect_hash{$_} = [ split /\//,$collect_list[$_] ] for (0 .. $#collect_list);

    my %structure_hash = ();
    my $chl2 = "";
    for (sort {$a <=> $b} keys %collect_hash) {
	$chl2 = (($collect_hash{$_}[-2] =~ /[Ll]egacy/) ? $collect_hash{$_}[-3] : $collect_hash{$_}[-2]);
	push @{$structure_hash{$chl2}},{$_, $collect_hash{$_}[-1]}; 
    }

    return %structure_hash;
}

sub parse_files {
    my %structure_hash = %{$_[0]};
    my @collect_list = @{$_[1]};
    my $out_file = $_[2];
    my $out_fh = undef;

    if ($out_file ne "-1") {
	open ($out_fh, ">", $out_file) or die "Cannot open '$out_file' for writing, $!";
	select $out_fh;
    }

    for (keys %structure_hash) {
    	my $chl2_title = $_;
    	$chl2_title =~ s/(\b[a-z])/\u$1/g;
    	print "<chl2><title>$chl2_title</title>\n";
    	for my $a_filename_hash (@{$structure_hash{$_}}) {
    	    for my $the_index (keys %{$a_filename_hash}) {
    		my $chl3_title = ${$a_filename_hash}{$the_index};
    		my $in_file;
    		my @file_content = ();
    		$chl3_title =~ s/(\b[a-z])/\u$1/g;
    		$chl3_title =~ s/_/ /g;
    		$chl3_title =~ s/(.*)\.[Ss]tory$/$1/;
    		print "<chl3><title>$chl3_title</title>\n";
    		my $the_path_to_file = substr($collect_list[$the_index],length($ENV{"HOME"}));
    		print "<!-- Beginning of $the_path_to_file -->\n";
		print STDERR "<!-- Beginning of $the_path_to_file -->\n";
    		open ($in_file,"<",$collect_list[$the_index]) or die "Cannot open '$collect_list[$the_index]': $!";
    		chomp(@file_content = <$in_file>);
    		close($in_file);
    		&parse_story($chl3_title,@file_content);
    		my $sum_of_lines = scalar(@file_content);
    		print STDERR "<!-- End of ${$a_filename_hash}{$the_index} ($sum_of_lines lines) -->\n";
    		print "<!-- End of ${$a_filename_hash}{$the_index} ($sum_of_lines lines) -->\n";
    		print "</chl3>\n";
    	    }
    	}
    	print "</chl2>";
    }

    if (defined($out_fh)) {
	close($out_fh);
	select STDOUT;
    }
}

sub parse_story() {
    my $caption_txt = shift @_;
    my $length_of_file = scalar(@_);
    for (my $i=0; $i<$length_of_file; $i++) {
	# print STDOUT "BEGIN: Line number: $i (out of $length_of_file)\n";
	$_[$i] =~ s/&/&amp;/g;
	$_[$i] =~ s/</&lt;/g;
	next if ($_[$i] =~ /^\s*$/);
	if ($_[$i] =~ s/^.*[Ss]cenario:\s*(.*)/<p>$1<\/p>/) {
	    print "$_[$i]\n";
	    while($_[$i+1] =~ s/^\s*([a-zA-Z].*)/<p>$1<\/p>/) {
		print $_[++$i];
	    }
	} elsif ($_[$i] =~ s/^Given\s*(.*)/<p>$1<\/p>/) {
	    print"<list>\n";
	    print "<p><emph type=\"medium\">Preparations</emph></p>\n";
	    print "<list-item>$_[$i]\n";
	    print "</list-item>\n";
	    while($_[$i+1] =~ s/^And\s*(.*)/<p>$1<\/p>/) {
		print "<list-item>$_[++$i]\n";
		if ($_[$i] =~ /.*:\s*<\/p>$/) {
	   	    while($_[$i+1] =~ /^\s+.*/) {
			print "<p><preform>$_[++$i]</preform></p>\n";
		    }
		}
		print "</list-item>\n";
	    }
	    if($_[$i+1] =~ s/^Then\s*(.*)/<p>$1<\/p>/) {
		print "<bridge><p><emph type=\"medium\">Action and Result</emph></p>\n";
		print "</bridge>\n";
		print "<list-item>$_[++$i]\n";
		print "</list-item>\n";
	    }
	    print "</list>\n";
	} elsif ($_[$i] =~ s/^When\s*(.*)/<p>$1<\/p>/) {
	    print "<step-list>\n";
	    print "<p><emph type=\"medium\">Action</emph></p>\n";
	    print "<sl-item>$_[$i]\n";
	    while($_[$i] =~ /.*,(<\/p>)?$/) {
	    	print "<p>$_[++$i]</p>\n";
	    }
	    print "</sl-item><!--in line $i-->\n";
	    while($_[$i+1] =~ s/^And\s*(.*)/<p>$1<\/p>/) {
		print "<!--First--><sl-item>$_[++$i]\n";
		print "</sl-item>\n";
	    }
	    ++$i while ($_[$i+1] =~ /^\s*$/);
	    while($i+1 < $length_of_file && $_[$i+1] =~ s/^Then\s*(.*)/<p>$1<\/p>/) {
	     	print "<bridge><p><emph type=\"medium\">Result</emph></p>\n";
	     	print "</bridge>\n";
	     	print "<sl-item>$_[++$i]\n";
	     	#print STDOUT "Line number: $i\n";
	     	print "</sl-item>\n";
	    }
	    while($i+1 < $length_of_file && $_[$i+1] =~ s/^And\s*(.*)/<p>$1<\/p>/) {
		print "<!--Second in line $i--><sl-item>$_[++$i]\n";
		print "</sl-item>\n";
	    }
	    print "</step-list>\n";
	} elsif ($_[$i] =~ s/^[Ee]xamples?:\s*(.*)/$1/) {
	    print "<example>\n";
	    print "<caption>$caption_txt</caption>\n";
	    print "<preform>";
	    # This may change, if multiple scenarios need to be factored in.
	    while (($i+1 < $length_of_file) && ($_[$i+1] !~ /^[Ss]cenario:.*/)) {
		next if ($_[++$i] =~ /^\s*$/);
		print "$_[$i]\n";
	    }
	    print "</preform>\n";
	    print "</example>\n";
	} elsif (($_[$i] =~ s/^!--\s*(.*)/$1/)) {
	    print "<!--$_[$i]-->\n";
	} else {
	    printf STDERR "%d: %s\n",$i,$_[$i];
	}
	# print STDOUT "END: Line number: $i (out of ".scalar(@_).")\n";
    }
}

sub parse_old {
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
