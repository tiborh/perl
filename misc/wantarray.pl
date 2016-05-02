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

my $flintstones = "fred,vilma,barney,betty";
my @FLINTSTONES = upcase(split /,/, $flintstones);
print "upcase in list context: @FLINTSTONES\n";
printf("upcase in scalar context %s\n",upcase(split /,/, $flintstones));
printf("upcase_simple in scalar context %s\n",upcase_simple(split /,/, $flintstones)); # no difference
print("another attempt: ",scalar(upcase(split /,/, $flintstones)),"\n");
print("another_simple attempt: ",scalar(upcase_simple(split /,/, $flintstones)),"\n"); # difference is obvious

sub upcase {
    my @params = map { uc } @_;
    # context dependent output:
    return wantarray ? @params : $params[0];
}

sub upcase_simple {
    my @params = map { uc } @_;
    # context dependent output:
    return @params;
}
