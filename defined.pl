#!/usr/bin/perl -w

$MAX = 3;

my @test_var;

$test_var[1] = "This is a string variable with line break at the end.\n";
$test_var[2] = 123456.789;

#undef values are not directly used in comparisons, but if you try to, use "eq undef"

for (my $i = 0; $i < $MAX; $i++)
{
    print defined($test_var[$i]) ? "defined\n" : "undefined\n";
}
