#!/usr/bin/perl -w

@rr_samp = (0,1,2,3);

$rr_samp[9] = 9;

foreach $item (@rr_samp) {
    print defined($item) ? "$item\n" : "(undef)\n";
}
