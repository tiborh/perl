#!/usr/bin/perl -w

# most obvious use: interpreting number as character
# if there are two dots, v is not needed
# if there is no dot or there is only one, v is needed

my $vString = v102.111.111; 	# foo
my $ipAddr = 204.148.40.9;	# IP address of O'Reilly
my $temp = v100;		# d
my $uniChar = v9786;		# smiley

print $vString,"\n";
print $ipAddr,"\n";
print $temp,"\n";
print $uniChar,"\n";
