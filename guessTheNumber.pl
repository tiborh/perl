#!/usr/bin/perl

$nuToGuess = int(rand 100);
print "I have a number between 0 and 100. Guess: ";

do {
    chomp($nuGuessed = <STDIN>);
  SWITCH: {
      if ($nuGuessed < $nuToGuess) {print "My number is greater than $nuGuessed. Try again: "}
      if ($nuGuessed > $nuToGuess) {print "My number is less than $nuGuessed. Try again: "}
      if ($nuGuessed == $nuToGuess) {print "That's it. The number is: $nuToGuess\n"}
    }
} while $nuGuessed != $nuToGuess;
