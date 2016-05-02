#!/usr/bin/env perl
use warnings;
use strict;
use Tkx;

my $mw = Tkx::widget->new(".");
$mw->g_wm_title("Hello, world");
$mw->g_wm_minsize(300, 200);

my $b;
$b = $mw->new_button(
    -text => "Hello, world",
    -command => sub {
    $b->m_configure( 		# m_ commands are tk subcommands
	-text => "Goodbye, cruel world",
	);
    Tkx::after(1500, sub { $mw->g_destroy }); # 1.5 seconds
    },
    );

# giving a padding around the buttons
$b->g_pack(
    -padx => 10,
    -pady => 10,
    );

my $msg = Tkx::tk___messageBox( # tk_messageBox(), but the underscore 
				  # would be transformed into space 
				  # resulting in an error
    -parent => $mw,
    -icon => "info",
    -title => "Tip of the Day",
    -message => "Please be nice!",
    );

Tkx::MainLoop();
