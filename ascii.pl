#!/usr/bin/perl -w

use strict;

print("    ");
for(my $i=0; $i<10; $i++) {
    printf("%3d",$i);
}
print("\n");

printf("%3d_ RS US SP",3);	# Record Separator, Unit Separator, Space
for(my $i=33; $i<127; $i++) {
    printf("%3c",$i);
    if (($i+1) % 10 == 0) {
	print("\n");
	printf("%3d_",($i+1)/10);
    }
}
print(" DEL");
print("\n");
