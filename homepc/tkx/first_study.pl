#!/usr/bin/env perl
use Tkx;

# The window:
Tkx::wm_title(".", "Feet to Meters"); # title of main window
Tkx::ttk__frame(".c",  -padding => "3 3 12 12"); # main frame
Tkx::grid( ".c", -column => 0, -row => 0, -sticky => "nwes"); # grid
Tkx::grid_columnconfigure( ".", 0, -weight => 1);	      # column
Tkx::grid_rowconfigure(".", 0, -weight => 1);		      # row

# Capstone
Tkx::MainLoop();
