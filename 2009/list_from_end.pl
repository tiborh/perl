#!/usr/bin/perl

@numlist = ("zero", "one", "two", "three", "four", "five");

print "List from first item to last:\n";
$, = " ";
print @numlist,"\n";

$list_length = $#numlist - $[ + 1;

for ($i=1;$i<=$list_length;$i++)
{
    print $numlist[-$i],"";
}
print "\n"

#end of list_from_end.pl
