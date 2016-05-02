#!/usr/bin/perl -w

use strict;
use Cwd;
use Time::Piece;
use File::Basename;
use Getopt::Std;
use v5.14;

my $DEBUG = 0;

{
    use HTML::Parser;
    my $p = HTML::Parser->new;
    # no good
    #$self->declaration("DOCTYPE SEIF PUBLIC");
    $p->parse("someting");
    $p->eof;
}
