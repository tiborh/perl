#!/usr/bin/perl -w

#an example from perldoc -f substr

$x = '1234';
for (substr($x,1,2)) {
    $_ = 'a';   print $x,"\n";    # prints 1a4
    $_ = 'xyz'; print $x,"\n";    # prints 1xyz4
    $x = '56789';
    $_ = 'pq';  print $x,"\n";    # prints 5pq9
}
