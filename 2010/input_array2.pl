#!/usr/bin/perl -w

@names = ("sol","luna","mercury","venus","gaia","mars","jupiter","saturn","uranos","neptune","pluto");
@in_array = ();

print("Give some numbers (0-10) separated with ENTERs and with Ctrl+D to end:\n");

chomp(@in_array = <STDIN>);

foreach (@in_array)
{
    if ($_ >= 0 && $_ <= 10)
    {
	print($names[$_]." ");
    }
    else
    {
	print("($_) ");
    }
}
print "\n";

#end of input_array2.pl
