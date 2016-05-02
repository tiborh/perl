#!/usr/bin/perl

use Switch;

$nuToGuess = int(rand 100);
print "I have a number between 0 and 100. Guess: ";

do {
    chomp($nuGuessed = <STDIN>);
    $toSwitch = $nuGuessed <=> $nuToGuess;
    switch ($toSwitch) {
	case -1 {print "My number is greater than $nuGuessed. Try again: "}
	case 1 {print "My number is less than $nuGuessed. Try again: "}
	case 0 {print "That's it. The number is: $nuToGuess\n"}
    }
} while $nuGuessed != $nuToGuess;
