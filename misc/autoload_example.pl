#!/usr/bin/env perl

use warnings;
use v5.14; 			# implies strict
use Carp;
use utf8;
use autodie;

binmode(STDOUT, ":utf8");

use autoload_example;

&Autoload_Example::blarg(30);
&Autoload_Example::glarb(40);
say "end of test";
