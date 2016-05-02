#!/usr/bin/perl -w

use Math::Trig;

$r=0;

print "Radius:";
$r = <STDIN>;

print "Read in:\t r = $r";
if ($r < 0)
{
    $r = 0;
}
printf("Circumference:\t 2pi * r = %5.2f\n",2*pi()*$r);
printf("Area:\t\t pi * r² = %5.2f\n",pi*$r**2); 

#end of circle.pl
