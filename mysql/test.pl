#!/usr/bin/perl

use strict;
use warnings;
use DBI;

# Connect to the database.
my $dbh = DBI->connect("DBI:mysql:database=testdb;host=localhost",
		       "etibhar", "Aikotoba12.",
		       {'RaiseError' => 1});

# Drop table 'foo'. This may fail, if 'foo' doesn't exist
# Thus we put an eval around it.
eval { $dbh->do("DROP TABLE foo") };
print "Dropping foo failed: $@" if $@;
print "(But it is OK to fail.)\n" if $@;

# Create a new table 'foo'. This must not fail, thus we don't
# catch errors.
$dbh->do("CREATE TABLE foo (id INTEGER, name VARCHAR(20))");

# INSERT some data into 'foo'. We are using $dbh->quote() for
# quoting the name.
$dbh->do("INSERT INTO foo VALUES (1, " . $dbh->quote("Tim") . ")");

# same thing, but using placeholders (recommended!)
$dbh->do("INSERT INTO foo VALUES (?, ?)", undef, 2, "Jochen");

# now retrieve data from the table.
my $sth = $dbh->prepare("SELECT * FROM foo");
$sth->execute();
while (my $ref = $sth->fetchrow_hashref()) {
    print "Found a row: id = $ref->{'id'}, name = $ref->{'name'}\n";
}
$sth->finish();
eval { $dbh->do("DROP TABLE foo") };

# Disconnect from the database.
$dbh->disconnect();
