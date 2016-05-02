#!/usr/bin/perl -w
use strict;

{
    my ($num1,$num2) = (10,7);
    print("$num1,$num2\n");
    printf("divident: %d\ndivisor: %d\nquotient: %f\n",$num1,$num2,$num1/$num2);
    printf("divident: %d\ndivisor: %d\nquotient: %d\n",$num1,$num2,$num1/$num2);
}

{
    my ($num1,$num2) = (10.0,7.0);
    print("$num1,$num2\n");
    printf("divident: %d\ndivisor: %d\nquotient: %f\n",$num1,$num2,$num1/$num2);
    printf("divident: %d\ndivisor: %d\nquotient: %d\n",$num1,$num2,$num1/$num2);
    printf("divident: %.1f\ndivisor: %.1f\nquotient: %f\n",$num1,$num2,$num1/$num2);
}

{
    use integer;
    my ($num1,$num2) = (10,7);
    print("$num1,$num2\n");
    printf("divident: %d\ndivisor: %d\nquotient: %f\n",$num1,$num2,$num1/$num2);
    printf("divident: %d\ndivisor: %d\nquotient: %d\n",$num1,$num2,$num1/$num2);
}

{
    use integer;
    my ($num1,$num2) = (10.1,7.1);
    print("$num1,$num2\n");
    printf("divident: %.1f\ndivisor: %.1f\nquotient: %f\n",$num1,$num2,$num1/$num2);
    printf("divident: %d\ndivisor: %d\nquotient: %d\n",$num1,$num2,$num1/$num2);
}
