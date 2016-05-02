#!/usr/bin/perl -w

use strict;

while (<>) {
    if (/([Oo]ne)(.*)([Tt]wo)|\3\2\1/) {
	print $_;
    }
}
