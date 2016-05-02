#!/usr/bin/perl -w

@in_array = (0..12);
$inline = "";
@ar_splice = ();

print(join(" ",@in_array) . "\n");

while(0<1) {
    print("give me three numbers: <place> <length> <replacement> (space-separated): ");
    chomp($inline=<STDIN>);
    printf("read in: %s\n",$inline);
    @ar_splice = split(" ",$inline);
    splice(@in_array,$ar_splice[0],$ar_splice[1],$ar_splice[2]);
    print(join(" ",@in_array) . "\n");
}

#end of splice2.pl
