#!/usr/bin/env perl
use Tkx;
    
Tkx::button(".b",
	    -text => "Hello, world",
	    -command => sub { Tkx::destroy("."); },
    );
Tkx::pack(".b");

Tkx::MainLoop()
