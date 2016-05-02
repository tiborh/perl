#!/usr/bin/perl -w

%BirthYears = (
    "William Shakespeare" => 1564,
    "Platon" => -428,
    "Aristotle" => -384,
    "Charles Darwin" => 1809,
    "Isaac Newton" => 1642,
    );

$, = "\n";

print "The whole hash:", %BirthYears,"";

print "Only one piece of data:", $BirthYears{'William Shakespeare'},"";

@ValueSorted = sort { $a <=> $b } values %BirthYears;

print "sorted by value: @ValueSorted\n";

@KeySorted = sort { $a cmp $b } keys %BirthYears;

print "sorted by key: @KeySorted\n";

print "Give me a name: ";

chomp($NameTemp = <STDIN>);

print "Type the year of birth belonging to it: ";

chomp($BirthYearTmp = <STDIN>);

$BirthYears{$NameTemp} = $BirthYearTmp;
#$BirthYears{$NameTemp} =();

print "The whole hash again:", %BirthYears,"";

print "exists? ($NameTemp) ", exists($BirthYears{$NameTemp})?"true\n":"false\n";
print "defined? ($NameTemp) ", defined($BirthYears{$NameTemp})?"true\n":"false\n";

print "Whose year of birth do you want to delete? ";

chomp($NameTemp = <STDIN>);

@RecDeleted = delete $BirthYears{$NameTemp};

print "The whole hash again:", %BirthYears,"";

print "Deleted record: @RecDeleted\n";

print "exists? ($NameTemp) ", exists($BirthYears{$NameTemp})?"true\n":"false\n";
print "defined? ($NameTemp) ", defined($BirthYears{$NameTemp})?"true\n":"false\n";
