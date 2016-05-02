#!/usr/bin/env perl
use Tkx;
Tkx::grid( Tkx::ttk__button(".b", -text => "Hello, world", -command => sub {Tkx::destroy(".");} ) );
Tkx::MainLoop();
