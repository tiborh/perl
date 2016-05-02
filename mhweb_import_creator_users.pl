#!/usr/bin/env perl

use warnings;
use 5.014; 			# implies strict
#use strict;
use Carp;
use utf8;
#use encoding 'utf8';
use autodie;
#use Modern::Perl;
#use Test::More;

if ($#ARGV < 1)
{
    print "Usage: $0 name_list mho_name\n";
    exit(1);
}

open (my $fh, "<", $ARGV[0]) or die "Cannot open $ARGV[0] for reading, $!";

print <<"EOB";
<mhoxml>
  <mho>$ARGV[1]</mho>
  <users>
EOB

while(<$fh>)
{
    chomp;
    print <<"EOB";
    <user>
      <mhoid>$ARGV[1]</mhoid>
      <userid>$_</userid>
      <isCNExpert>false</isCNExpert>
      <isCNHandler>false</isCNHandler>
      <isCNMeetingSecretary>false</isCNMeetingSecretary>
      <isTRExpert>true</isTRExpert>
      <isTRAdministrator>false</isTRAdministrator>
      <isTRHandler>false</isTRHandler>
      <isCHExpert>false</isCHExpert>
      <isCHHandler>false</isCHHandler>
      <isPKExpert>false</isPKExpert>
      <isPKHandler>false</isPKHandler>
      <responsible>false</responsible>
      <assistant>false</assistant>
    </user>
EOB
}

print <<"EOB";
  </users>
</mhoxml>
EOB
