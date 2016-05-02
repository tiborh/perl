#!/usr/bin/env perl
use Tkx;

# The window:
Tkx::wm_title(".", "Feet to Meters"); # title of main window
Tkx::ttk__frame(".c",  -padding => "3 3 12 12"); # main frame
Tkx::grid( ".c", -column => 0, -row => 0, -sticky => "nwes"); # grid
Tkx::grid_columnconfigure( ".", 0, -weight => 1);	      # column
Tkx::grid_rowconfigure(".", 0, -weight => 1);		      # row

# Widgets in the window
Tkx::ttk__entry(".c.feet", -width => 7, -textvariable => \$feet); # entry
Tkx::grid(".c.feet", -column => 2, -row => 1, -sticky => "we");	  # place in grid
Tkx::ttk__label(".c.meters", -textvariable => \$meters);	  # label
Tkx::grid(".c.meters", -column => 2, -row => 2, -sticky => "we"); # place in grid
Tkx::ttk__button(".c.calc", -text => "Calculate", -command => sub {calculate();}); # button + binding
Tkx::grid(".c.calc", -column => 3, -row => 3, -sticky => "w"); # place in grid
Tkx::ttk__button(".c.exit", -text => "Exit", -command => sub {Tkx::destroy(".");}); # button + binding
Tkx::grid(".c.exit", -column => 1, -row => 3, -sticky => "w"); # place in grid

sub calculate {
   $meters = int(0.3048*$feet*10000.0+.5)/10000.0 || '';
}

# Capstone
Tkx::MainLoop();
