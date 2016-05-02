#!/usr/bin/perl -w
use strict;
use person1;

# print "It works!\n";

print "Population: ", Person->headcount, "\n";

my $object = Person->new (
    surname => "Doe",
    firstname => "Joe",
    address => "12 Oak Street",
    occupation => "carpenter"
);

print "Population: ", Person->headcount, "\n";

my $object = Person->new (
    surname => "Smith",
    firstname => "John",
    address => "12 Chestnut Street",
    occupation => "writer"
);

print "Population: ", Person->headcount, "\n";

print "Members: ", Person->everyone, "\n";

print "Listing existing attribs:\n";
$object->list_attribs();

print "first name: ",$object->get_attrib("firstname"),"\n";
print "setting first name\n";

$object->set_attrib("firstname","Jane");
print "first name: ",$object->get_attrib("firstname"),"\n";

print "trying to print non-existing phone:\n";
print $object->get_attrib("phone");

print "setting phone number\n";
$object->set_attrib("phone",123456);

print "getting phone again: ",$object->get_attrib("phone"),"\n";

print "calling attrib() without argument (undef is returned)\n";
print $object->attrib();

print "calling attrib() with age (does not exist yet)\n";
print $object->attrib("age");

print "setting age\n";
print $object->attrib("age",23),"\n";

print "getting age again: ";
print $object->attrib("age"),"\n";

print "calling a non-existing method\n";
$object->fancy_thing;

print "Population: ", Person->headcount, "\n";

print "Destructor is called automatically at the end.\n";
exit(0);
