#!/usr/bin/perl

$testvar = " something ";
%testhash = ("testval" => $testvar);

print "|$testvar|\n";

chop($testvar);

print "|$testvar|\n";

print "|",%testhash,"|\n";

chop($testhash{"testval"});

print "|",%testhash,"|\n";
