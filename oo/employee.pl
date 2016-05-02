#!/usr/bin/perl

use employee;
my $CLASS_TO_TEST = "Employee";

$object = new Employee( "Mohammad", "Saleem", 23234345);
# Get first name which is set using constructor.
$firstName = $object->getFirstName();

print "Before Setting First Name is : $firstName\n";

# Now Set first name using helper function.
$object->setFirstName( "Mohd." );

# Now get first name set by helper function.
$firstName = $object->getFirstName();
print "After Setting First Name is : $firstName\n";

use test_package;

TestPackage::list_package_vars($CLASS_TO_TEST);
