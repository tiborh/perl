#!/usr/bin/perl -w

@in_array = ();

print("type some strings (<Enter> separated):\n");
chomp(@in_array = <STDIN>);

print(1..9,0..9,0,"\n");

foreach (@in_array) {
    printf("%20s\n",$_);
}

#end of input_array.pl
