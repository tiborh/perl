#!/usr/bin/perl

$input_file = "grades.txt";
$output_file = "averages.txt"; 

open(GRADES,$input_file) or die "Can't open '$input_file': $!";
while ($line = <GRADES>) {
    ($student, $grade) = split(" ",$line);
    $grades{$student} .= $grade . " ";
}
close(GRADES);

open(AVERAGES,">".$output_file) or die "Can't open '$output_file': $!";

print %grades, "\n";

foreach $student (sort keys %grades) {
    $scores = 0;
    $total = 0;
    @grades = split(" ", $grades{$student});
    foreach $grade (@grades) {
	$total += $grade;
	$scores++;
    }
    $average = $total / $scores;
    print "$student:\n\t$grades{$student}\tAverage: $average\n";
    print AVERAGES "$student:\n\t$grades{$student}\tAverage: $average\n";
}

close(AVERAGES);
