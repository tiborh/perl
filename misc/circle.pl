#!/usr/bin/perl -w

use strict;
use Math::Trig;

my $pi_value = pi;
my $radius = 0;
my $circum = 0;
my $area = 0;

print("radius: ");
chomp(my $input = <stdin>);
$radius = sprintf("%f",$input);
$radius = 0 if ($radius < 0);
print "radius: $radius\n";
printf("circumference: %f (2*r*pi)\n",2*$radius*$pi_value);
printf("area: %f (pi*r**2)\n",$radius**2*$pi_value);
