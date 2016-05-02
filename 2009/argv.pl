#!/usr/bin/perl -w

if (($argv = @ARGV) < 2) {
    die "Usage: script_name <input filename> <output_filename>";
}

print "argv in scalar context: $argv\n";
for ($i = 0; $i < $argv; $i++) {
    print "argv$i: $ARGV[$i], ";
}

