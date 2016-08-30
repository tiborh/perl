#!/usr/bin/env perl

use warnings;
use v5.10; 			# implies strict
use Carp;
use utf8;
use autodie;
#the following two needs installation:
#use Modern::Perl;
#use Test::More;

binmode(STDOUT, ":utf8");

my $ascalar;
my $refscalar = \$ascalar;
say "refscalar: ",ref($refscalar);
my $arrRef = [];
say "refarray: ",ref($arrRef);
my $hashRef = {};
say "refhash: ",ref($hashRef);
my $subref = sub { say "something: @_" };
say $subref;			# CODE
say "subref: ",ref{$subref};	# recognised as hash, not as CODE

my $returned = $subref->();
say "returned: $returned";
$returned = $subref->("else");
say "returned: $returned";

$subref = \&test_sub;
say "subref: $subref";
say "subref: ",ref{$subref};	# recognised as hash, not as CODE
$returned = $subref->("else");
say "returned: ",$returned || "undef";

say 'the variable $subref points at: ', ref($subref) eq "CODE" ? "CODE" : "NON-CODE";

my $regref = qr/[A-Z]{2}[0-9]{5}/;
say "regref: ",ref($regref);

my $refref = \$refscalar;
say "ref to ref: ",ref($refref);

# unsuccessful attempts:
# my $globref = \{<"*e f*">};
# say "globref: ",$globref;
# say "globref: ",ref($globref);
# $globref = {<"*e f*">};
# say "globref: ",$globref;
# say "globref: ",ref($globref);
# say 'is $globref a glob reference? ', ref($globref) eq "GLOB" ? "Yes" : "No" ;

my $fn = "test_csv.csv";
open my $fh,"<",$fn or croak "cannot open: $fn, $@";
say "filehandle reference; ",ref($fh);
close($fh);

format formatref = 
     Test: @<<<<<<<< @||||| @>>>>>
.
say '$formatref: ',ref(*formatref{FORMAT});

my $text = 'The black cat climbed the green tree';
my $refleftval = \ substr $text, 14, 7;

say '$refleftval: ',ref($refleftval);


my $r = {};
print "plain hash reference: ";
say ref $r;              # HASH
bless $r, 'Some::Name';
print "When it becomes a blessed reference: ";
say ref $r;

my $ioref = *glob{IO};
say "it is almost impossible to create IO references:";
say "ioref: ",ref($ioref) eq "IO" ? "IO" : "non-IO";

use Symbol;
# replace *FOO{IO} handle but not $FOO, %FOO, etc.
*FOO = geniosym;
say "Another failed attempt: *FOO: ", ref(*FOO)," (nothing again)";

say "the only way: ",ref *STDIN{IO}," (even if it is IO::FILE)";

say "vstring reference: ",ref \v5.10.0;

sub test_sub {
    say "test_sub args: @_";
    return;
}
