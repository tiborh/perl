#!/usr/bin/env perl

use warnings;
use v5.14; 			# implies strict
use Carp;
use utf8;
use autodie;
#the following two needs installation:
#use Modern::Perl;
#use Test::More;

use TestTools;

binmode(STDOUT, ":utf8");

&TestTools::print_head("test_caller");
&test_caller();
&TestTools::print_head("test_caller_extended");
&test_caller_extended();
eval {
    &TestTools::print_head("test_caller_extended in eval block");
    my @testarr = &test_caller_extended;
};
carp $@ if $@;
my $result;
my $sub_ref = \&test_caller_extended;
&TestTools::print_head("eval called with sub reference");
eval '$result = $sub_ref->(1, 2, 3)';
carp $@ if $@;
&caller_of_test_caller;
&caller_of_caller_of_test_caller;

sub test_caller {
    my @info = caller();
    say "length of caller info: ",scalar(@info);
    say "caller info:";
    say "\tpackage: $info[0]";
    say "\tfile: $info[1]";
    say "\tline: $info[2]";
}

sub caller_of_caller_of_test_caller {
    &TestTools::print_head("caller of caller of test caller");
    &caller_of_test_caller;
}

sub caller_of_test_caller {
    &TestTools::print_head("caller(0)");
    &test_caller_extended(caller(0));
    &TestTools::print_head("caller(1)");
    &test_caller_extended(caller(1));
}

sub test_caller_extended {
    my @info = @_ || caller(0);
    say "Caller with number argument:";
    say "\t 0. package:    ",$info[0] || "under";
    say "\t 1. filename:   ",$info[1] || "undef";
    say "\t 2. line:       ",$info[2] || "under";
    say "\t 3. subroutine: ",$info[3] || "under";
    say "\t 4. has args:   ",$info[4] ? "yes (1)" : "no (\"\")";
    my $wantxt;
    if ($info[5]) {
	$wantxt = "list context (1)";
    } elsif (defined($info[5])) {
	$wantxt = "scalar context (defined but uninitialised)";
    } else {
	$wantxt = "null context (undef)";
    }
    say "\t 5. wantarray:  ",$wantxt;
    my $evaltxt;
    if ($info[6]) {
	$evaltxt = "set: $info[6]";
    } elsif (defined($info[6])) {
	$evaltxt = "defined but uninitialised";
    } else {
	$evaltxt = "undef";
    }
    say "\t 6. eval text:  ",$evaltxt;
    my $is_require;
    if ($info[7]) {
	$is_require = "set: $info[7]";
    } elsif (defined($info[7])) {
	$is_require = "defined but uninitialised";
    } else {
	$is_require = "undef";
    }
    say "\t 7. is require: ",$is_require || "under";
    say "\t 8. hints:      ",$info[8] || "under";
    say "\t 9. bitmask:    ",$info[9] || "under";
    say "\t10. hinthash:   ",$info[10] || "under";
}
