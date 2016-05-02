#!/usr/bin/env perl
use warnings;
use strict;
use Tkx;

# It's important to have objects 
# because the "." syntax cannot be 
# used as widely as in tcl
my $mw = Tkx::widget->new(".");
my $b = $mw->new_button(
    -text => "Hello, world",
    -command => sub { $mw->g_destroy; }, # g_ commands are tk commands
    );
$b->g_pack;

Tkx::MainLoop()
