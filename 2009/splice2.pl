#!/usr/bin/perl -w


@alpha = ('a' .. 'z');

#add two new values
#push(@alpha, "X", "Y");
splice (@alpha, @alpha, 0, "X", "Y");

$, = ' ';

#add a newline.
#push(@alpha, "\n");
splice(@alpha, @alpha, 0, "\n");

print @alpha;

#pop(@alpha);
splice(@alpha, -2);
splice(@alpha, @alpha, 0, "\n");
#shift(@alpha);
splice(@alpha, 0, 1);
#unshift(@alpha);
splice(@alpha, 0, 0, "A");
#$alpha[7]="F";
splice(@alpha, 5, 1, "F");

print @alpha;
