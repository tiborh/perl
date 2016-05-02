#!/usr/bin/perl

use strict;
use warnings;
use DBI;

# Connect to the database.
my $dbh = DBI->connect("DBI:mysql:database=MHEXTDB;host=localhost",
		       "cgibin", "gingSimil",
		       {'RaiseError' => 1});

# now retrieve data from the table.
# heading removed
#my $properties = "eriref,priority,status,regdate,designdate,mhodate,mhodays";
my $properties = "eriref,priority,status,regdate,datediff(curdate(),str_to_date(regdate,'%Y-%m-%d')) as 'regdays',primtechuser,heading";
#my $where_cond = "designmho=\"ceadev\" and (status=\"re\" or status=\"as\" or status=\"pp\")";
my $where_cond = "designmho='ceadev' and status not in ('pr','ca')";
my $order_str = "priority,eriref";

my $sql_str = "select $properties from TR where $where_cond order by $order_str";
print "query used:\n\t$sql_str\n";

#print "the sql string:\n|$sql_str|\n";

my $sth = $dbh->prepare($sql_str) || die "Error:" . $dbh->errstr . "\n";

$sth->execute() || die "Error:" . $sth->errstr . "\n";

my $names = $sth->{NAME};
my $numFields = $sth->{'NUM_OF_FIELDS'} - 1;
for my $i ( 0..$numFields ) {
      printf("%s%8s", $i ? " " : "", substr $names->[$i],0,8);
}
print "\n";

#while (my $ref = $sth->fetchrow_hashref()) {
#}
my $nu_of_rows = 0;
while (my $ref = $sth->fetchrow_arrayref) {
      for my $i ( 0..$numFields ) {
	  printf("%s%4s", $i ? "\t" : "", defined($ref->[$i]) ? substr $ref->[$i],0,75 : "NULL");
      }
      print "\n";
      $nu_of_rows++;
}
    print "($nu_of_rows rows)\n";
$sth->finish();

# Disconnect from the database.
$dbh->disconnect();
