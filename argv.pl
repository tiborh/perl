#!/usr/bin/perl

printf("Number of args: %d\n",scalar(@ARGV)); # $#ARGV+1 is also good

while (@ARGV) {
    $currArg = shift(@ARGV);
    printf("%s\n",$currArg);
}
