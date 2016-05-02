package NonOO v0.0.1 {
  my $myVar = 0;
  local $myVar1 = 1;
  our $myVar2 = 2;
  our @myArr = (1,2,3);
  our %myHash = (1,2,3,4);
  sub mySub { print "Happy!\n"; }
}
1;
