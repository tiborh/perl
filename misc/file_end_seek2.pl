#!/usr/bin/perl -w

use strict;

&main(0);

sub main {
    for (@ARGV) {
	my $fh;
	my $fm = "<";
	my $fn = $_;
	my $line_print = $_[0];
	my $saved_line = "";

	print "\n$fn:\n";
	print "-" x length($fn);
	print "\n";
	open($fh,$fm,$fn) or warn "unable to open: $!";
	if (!&proc_file($_[0],$fh)) {
	    print "File does not end with an empty line.\n";
	} else {
	    print "OK\n";
	}
	close($fh);
    }
}

sub proc_file {
    my $line_print = $_[0];
    my $fh = ${$_[1]};
    my $data_in = "";
    my $coll_str = "";
    my $saved_line = "";

    while(read($fh,$data_in,1)) {
	$coll_str .= $data_in;
	if ($data_in eq "\n") {
	    print $coll_str if $line_print;
	    $saved_line = $coll_str;
	    $coll_str = "";
	}
    }
    $saved_line = $coll_str if (($saved_line ne $coll_str) && ($coll_str ne ""));

    if ($line_print) {
	print "last saved line: '";
	for(my $i=0;$i<length($saved_line);$i++){
	    printf "%02x ",ord(substr($saved_line,$i,1));
	}
	print "'\n";
    }
    return ($saved_line =~ /(\n$)|(^\s*$)/) ? 1 : 0;
}

    #my $cur_pos = "";

#$cur_pos = tell($fh);
#seek($fh,$cur_pos,0);
