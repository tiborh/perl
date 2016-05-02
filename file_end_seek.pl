#!/usr/bin/perl -w

use strict;

&main();

sub main {
    for (@ARGV) {
	my $fh;
	my $fm = "<";
	my $fn = $_;

	print "\n$fn:\n";
	print "-" x length($fn);
	print "\n";
	if (-z) {
	    print "<Empty file>\n";
	    next;
	}
	open($fh,$fm,$fn) or warn "Unable to open: $!";
	print((&proc_file($fh)) ? "OK\n" : "File does not end with an empty line.\n");
	close($fh);
    }
}

sub proc_file {
    my $fh = ${$_[0]};
    my $data_in = "";
    my $coll_str = "";
    my $saved_line = "";

    while(read($fh,$data_in,1)) {
	$coll_str .= $data_in;
	($saved_line,$coll_str) = ($coll_str,"") if ($data_in eq "\n");
    }
    $saved_line = $coll_str if (($saved_line ne $coll_str) && ($coll_str ne ""));

    return ($saved_line =~ /(\n$)|(^\s*$)/) ? 1 : 0;
}
