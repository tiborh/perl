#!/usr/bin/perl

if (($argv = @ARGV) < 2) {
    die "Usage: script_name <input filename> <output_filename>";
}

open IN_FILE, "<$ARGV[0]" or die "Cannot open \"$ARGV[0]\"";
open OUT_FILE, ">$ARGV[1]" or die "Cannot open \"$ARGV[1]\"";

print OUT_FILE "<glossary>\n";
print OUT_FILE "<glossary-list>\n";
while ($line = readline(IN_FILE)) {
    @linelist = split(/"/, $line);
    $linelist = @linelist;
    if ($linelist != 5) {
	die "The format of each line must be: \"string1\",\"string2\"";
    }
    print OUT_FILE "<gl-item>\n";
    print OUT_FILE "<term>$linelist[1]</term>\n";
    print OUT_FILE "<expansion><p>$linelist[3]</p>\n";
    print OUT_FILE "</expansion>\n";
    print OUT_FILE "</gl-item>\n";
}
print OUT_FILE "</glossary-list>\n";
print OUT_FILE "</glossary>\n";

close IN_FILE;
close OUT_FILE;
