#!/usr/bin/perl -w

sub funkshun {
    print @_;
}

my $Price = '$5.49';

print <<EOF;    # same as an earlier example
The price is $Price.
EOF

print <<"EOF";  # same as above, with explicit quotes
The price is $Price.
EOF

print <<'EOF';    # single-quoted quote
All things (e.g. a camel's journey through
A needle's eye) are possible, it's true.
But picture how the camel feels, squeezed out
In one long bloody thread, from tail to snout.
                                -- C.S. Lewis
EOF

#print << x 10;    # print next line 10 times
#The camels are coming!  Hurrah!  Hurrah!

print <<"" x 10;  # the preferred way to write that
The camels are coming!  Hurrah!  Hurrah!

print <<`EOC`;    # execute commands
echo hi there
echo lo there
EOC

print <<"dromedary", <<"camelid";   # you can stack them
I said bactrian.
dromedary
She said llama.
camelid

funkshun(<<"THIS", 23, <<'THAT');   # doesn't matter if they're in parens
Here's a line
or two.
THIS
And here's another.
THAT

print <<'odd'
2345
odd
    + 10000;   # prints 12345 If you want your here docs to be indented with the rest of the code, you'll need to remove leading whitespace from each line manually: 

    print "\n print <<'odd' was not closed with a ; therefore +10000 has been added to the number of 2345\n";

# $quote is created and value is given with a here file:
($quote = <<'QUOTE') =~ s/^\s+//gm;
    The Road goes ever on and on,
    down from the door where it began.
QUOTE

print $quote;

# an array can be populated with a here file:
@sauces = <<End_Lines =~ m/(\S.*\S)/g;
   normal tomato
   spicy tomato
   green chile
   pesto
   white wine
End_Lines

$" = "\n";

print "@sauces\n";
