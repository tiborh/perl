#!/usr/bin/perl -w

@in_array = ();

chomp(@in_array = <STDIN>);

print(join(" ",sort(@in_array)) . "\n");
print(join("\n",sort(@in_array)) . "\n");

#end of input_array3.pl
