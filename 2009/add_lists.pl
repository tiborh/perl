#!/usr/bin/perl -w

sub show_list;

@colours = ("yellow", "green", "blue", "black");
@more_cols = ("white", "red", "purple", "pink");

print "first list:\n";
show_list(@colours);
print "second list:\n";
show_list(@more_cols);
@list_sum = (@colours, @more_cols, "brown");
print "two lists added:\n";
show_list(@list_sum);
print "push() can be used to say how many elements\n";
$number_of_elements = push(@colours, @more_cols, "brown");
print $number_of_elements,"\n";

sub show_list {
    my @list = @_; #@_: the parameter given for the subroutine
    $i = 0;
    for (@list)
    {
	print $list[$i],"\n";
	$i++;
    }

}
