#!/usr/bin/perl -w

sub print_nums;

@range = (101 .. 200);
@egnar = reverse (101 .. 200);

print_nums(@range);
print_nums(@egnar);


#subroutine for printing the num lists
sub print_nums {
    my @list = @_; #@_: the parameter given for the subroutine
    for($i=0;$i<100;$i++)
    {
	print $list[$i]," ";
	if(($i+1) % 10 == 0)
	{
	    print "\n"
	}
    }
    print "\n";
}

