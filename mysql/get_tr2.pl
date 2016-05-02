#!/usr/bin/perl

use strict;
use warnings;
use DBI;

# Connect to the database.
my $dbh = DBI->connect("DBI:mysql:database=MHEXTDB;host=localhost",
		       "cgibin", "gingSimil",
		       {'RaiseError' => 1});

die "eriref is needed as argument" if ($#ARGV < 0);

my $properties = "*";

my $where_cond = "eriref=\"$ARGV[0]\"";

my $sql_str = "select $properties from TR where $where_cond";
print "query:\n\t$sql_str";

my $sth = $dbh->prepare($sql_str) || die "Error:" . $dbh->errstr . "\n";

$sth->execute() || die "Error:" . $sth->errstr . "\n";

my $names = $sth->{NAME};
my $numFields = $sth->{'NUM_OF_FIELDS'} - 1;

#for my $i ( 0..$numFields ) {
#      printf("%s%8s", $i ? "\t" : "", $$names[$i]);
#}
print "\n";

while (my $ref = $sth->fetchrow_arrayref) {
      for my $i ( 0..$numFields ) {
	  print $names->[$i],"\t";
	  print defined($ref->[$i]) ? $ref->[$i] : "<undefined>";
	  print "\n";
      }
}

$sth->finish();

# Disconnect from the database.
$dbh->disconnect();
