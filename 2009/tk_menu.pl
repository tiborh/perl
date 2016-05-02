#!/usr/bin/perl -w
 use strict;
 use Tk;

my $main = MainWindow->new();
MainLoop();

my $menu=$main->Frame(-relief=>'groove',
		      -borderwidth=>3,
		      -background=>'black',) 
my $button1=$menu->Menubutton(-text=>'File',
			      -background=>'black',
			      -activebackground=>'blue',
			      -foreground=>'white',)
    ->pack(-side=>'left');
$button1->command(-label=>'Exit',
		  -activebackground=>'blue',
		  -foreground=>'white',
		  -command=>sub{$main->destroy}); 
