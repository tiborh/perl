#!/usr/bin/perl -w

@lcolours = ("white", "yellow", "pink");
@dcolours = ("black", "blue", "brown");
$lcol = "cyan";
$dcol = "purple";
#@colours = (@lcolours, @dcolours);

splice(@colours, 0, 0, (@lcolours, @dcolours));

#setting the separating character for printed arrays:
$, = "\n"; #only one character can be given

print "\@colours: @colours\n";


$numelems = @colours; #you need to put it into a variable
#if you do not want to break up the print statement with quotes.
print "The number of elements in \@colours: $numelems\n";

print "--Light colours: @lcolours\n";
print "--Dark colours: @dcolours\n";
print "--All colours: @colours\n";

#$popped = pop(@colours);
$popped = splice(@colours, -1);
print "--'pop' returns: $popped\n";
#print "--After 'pop(\@colours)': @colours\n";
print "--After 'splice(\@colours,-1)': @colours\n";
#$shifted = shift(@colours);
$shifted = splice(@colours,0,1);
print "--'shift' returns: $shifted\n";
#print "--After 'shift(\@colours)': @colours\n";
print "--After 'splice(\@colours,0,1)', same as shift(\@colours): @colours\n";

#instead of a scalar, another array can also be added in the following:
#print "--'push' returns: ", push(@colours, $dcol), ""; 
splice(@colours, @colours, 0, $dcol);
print "--splice(\@colours,\@colours,0,\$dcol), which is equivalent to push(\@colours,\$dcol), returns nothing.\n"; 
print "--After this 'push':", @colours, "";
# print "--'unshift' returns: ", unshift(@colours, $lcol), "";
print "--splice(\@colours,0,0,\$lcol), which is equivalent to unshift(\@colours,\$lcol), also returns nothing.\n"; 
splice(@colours, 0, 0, $lcol);
print "--After this 'unshift':", @colours, "";
#of course, simply adding them up would also have worked, eg.
#@colours = ($lcol,@colours,$dcol);
#much simpler, isn't it?

print "--The 1st element of the array: $colours[0]\n";
print "--The last element of the array: $colours[-1]\n";
@sliced = @colours[0..2,-1];
print "--Let's slice it up: @sliced\n";

print "swapping two elements\n"; 
@colours[2,4]=@colours[4,2];
print @colours,"";

#end arrays.pl
