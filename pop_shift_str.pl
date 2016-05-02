#!/usr/bin/env perl

use warnings;
use 5.014; 			# implies strict
use Carp;
use utf8;
use autodie;

binmode(STDOUT, ":utf8");

my $tstr = "始めまして。";
my @collector = ();

print("Test string: '$tstr'\n");

while(my $a_char = &popstr(\$tstr))
{
    print("popped: $a_char\t<-\t");
    print("remaining: $tstr\n");
    unshift(@collector,$a_char);
}

print("collector: @collector\n");

while(my $a_char = shift(@collector))
{
    print("push: '$a_char'\t->\t'$tstr'\n");
    pushstr(\$tstr,$a_char);
}

print("test string: $tstr\n");

while(my $a_char = &shiftstr(\$tstr))
{
    print("shifted: $a_char\t<-\t");
    print("remaining: $tstr\n");
    push(@collector,$a_char);
}

print("collector: @collector\n");

while(my $a_char = pop(@collector))
{
    print("unshift: '$a_char'\t->\t'$tstr'\n");
    unshiftstr(\$tstr,$a_char);
}

print("test string: $tstr\n");

sub unshiftstr()
{
    # $_[0] is the reference to string to unshift into
    # $_[1] is the char to push into the string
    return if (length($_[1]) != 1);
    substr(${$_[0]},0,0,$_[1]);
}

sub pushstr()
{
    # $_[0] is the reference to string to push to
    # $_[1] is the char to push into the string
    return if (length($_[1]) != 1);
    substr(${$_[0]},length(${$_[0]}),0,$_[1]);
}

sub shiftstr()
{
    # $_[0] is the reference to string to shift from
    # return: the shifted char
    return if (length(${$_[0]}) == 0);
    my $outstr = substr(${$_[0]},0,1);
    ${$_[0]} = substr(${$_[0]},1);
    return $outstr;
}

sub popstr()
{
    # $_[0] is the reference to string to pop from
    # return: the popped char
    return if (length(${$_[0]}) == 0);
    my $outstr = substr(${$_[0]},-1);
    ${$_[0]} = substr(${$_[0]},0,length(${$_[0]})-1);
    return $outstr;
}
