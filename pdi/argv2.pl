#!/usr/bin/env perl

use warnings;
use 5.014; 			# implies strict
use Carp;
use utf8;
use autodie;
#the following two needs installation:
#use Modern::Perl;
#use Test::More;

print("args: ",$#ARGV+1,"\n");
print("Having a look at the args: ",&theArgs(@ARGV),"\n");
print("args: ",$#ARGV+1,"\n");

sub theArgs {
    print(shift(@_)," ($#_)\n") while(@_);
    return($#_ > -1 ? shift(@_) : "empty");
}
