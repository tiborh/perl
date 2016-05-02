#!/usr/bin/perl -w

use strict;
use Tk;
use Tk::Balloon;

my $mw = MainWindow->new(
    -title => "Simple Balloon example",
    );
my $button = $mw->Button(
    -text => "Exit", 
    -command => sub { exit },
    )->pack(-pady => 25);
my $msgarea = $mw->Label(
    -borderwidth => 2, 
    -relief => 'groove',
    -width => 35,
    )->pack(-side => 'bottom', -fill => 'x');
my $balloon = $mw->Balloon(
    -statusbar => $msgarea
    );
$balloon->attach($button, 
		 -balloonmsg => "Exit the App",  
		 -statusmsg => "Press the Button to exit the application",
		 -balloonposition => 'mouse',
    );
$balloon->attach($msgarea, 
		 -msg => 'Displays the help text for a widget'
    );
MainLoop;
