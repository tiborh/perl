#!/usr/bin/perl -w

use utf8; # to allow the name of variables to be any unicode character

binmode STDOUT, 'encoding(UTF-8)'; # to avoid complaints about "Wide character in print"

my $いんでくす = "";
my $ばりゅう = "";
my @あれい = qw(一月 二月 三月 四月 五月 六月 七月 八月 九月 十月 十一月 十二月);
#note: hashes do not guarantee the order of values the same way as arrays
my %はっしゅ = (
    いちがつ => 一月,
    にがつ => 二月,
    さんがつ => 三月,
    しがつ => 四月,
    ごがつ => 五月,
    ろくがつ => 六月,
    しちがつ => 七月,
    はちがつ => 八月,
    くがつ => 九月,
    じゅうがつ => 十月,
    じゅういちがつ => 十一月,
    じゅうにがつ => 十二月,
);

#hashes are not sorted
print "Printing the months from a hash:\n";
while (($いんでくす, $ばりゅう) = each %はっしゅ) {
    print "$いんでくす: \t $ばりゅう\n";
}

#string sort does not help too much either
print "\nTrying a sort by values:\n";
my @月 = sort {$a cmp $b} values %はっしゅ;
print "@月\n";

#sort by key gives the same results
print "\nTrying to with 'sort' by keys:\n";
foreach $いんでくす (sort {$はっしゅ{$a} cmp $はっしゅ{$a}} keys %はっしゅ) {
    print "$いんでくす: \t $はっしゅ{$いんでくす}\n";
}

# since the appearance of 5.12, 'each' can be used both with hash and array
print "\nTesting 'each' with array:\n";
while (($いんでくす, $ばりゅう) = each @あれい) {
    print "$いんでくす: \t $ばりゅう\n";
}
