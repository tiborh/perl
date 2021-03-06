#!/usr/bin/perl -w

use Tk;

&popup;
print "Bye!\n";

sub popup {
    my $mw = MainWindow->new;
    $mw->title("Hello world");
    $mw->Label(
	-text => "Hello world!", 
	-height => 3,
	-width => 20,
	)->pack;
    $mw->Button(
	-text => "Hello", 
	-width => 10,
	-command => sub{
	    warn "Hello.\n"; 
	}
	)->pack;
    $mw->Button(
	-text => "Destroy", 
	-width => 10,
	-command => sub{
	    warn "Destroying window.\n"; 
	    $mw->destroy;
	}
	)->pack;
    $mw->Button(
	-text => "Exit", 
	-width => 10,
	-command => sub{
	    warn "Exiting.\n"; 
	    exit;
	}
	)->pack;
    MainLoop;
}
