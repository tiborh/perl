#!/usr/bin/env perl

use warnings;
use 5.014; 			# implies strict
use Carp;
use utf8;
use autodie;
#the following two needs installation:
#use Modern::Perl;
#use Test::More;
use person;

binmode(STDOUT, ":utf8");

my $min_required_version = 0.0.2;
Person->VERSION($min_required_version);

my $a_person = new Person( "Mohammad", "Saleem", 23234345);

&print_person_data($a_person);

print("Print all data:\n");
$a_person->print();

my $person2 = new Person();
$person2->print();
&print_person_data($person2);
$person2->setFirstName("Joe");
$person2->setLastName("Doe");
$person2->setSSN("000000");
&print_person_data($person2);

$person2->reset();		# testing AUTOLOAD

sub print_person_data()
{
    my $aPerson = shift;
    
    print "First name: ", defined($aPerson->getFirstName()) ? $aPerson->getFirstName() : "(undef)","\n";
    print "Last name: ", defined($aPerson->getLastName()) ? $aPerson->getLastName() : "(undef)","\n";
    print "SSN: ", defined($aPerson->getSSN()) ? $aPerson->getSSN() : "(undef)","\n";
}
