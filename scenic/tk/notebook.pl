#!/usr/bin/perl -w
#demo program from Mastering Perl/Tk by Steve Lidie & Nancy Walsh

use strict;
use Tk;
require Tk::NoteBook;
use utf8;
use encoding 'utf8';

my $mw = MainWindow->new( );

# Create the notebook and fill the whole window
my $nb = $mw->NoteBook( )->pack(-expand => 1, -fill => 'both');

# Page 1 on the notebook, with button on that page
my $p1 = $nb->add('page1', -label => 'Page 1');
$p1->Button(-text => 'Click me!')->pack( );

# Empty page 2
$nb->add('page2', -label => 'Page 2');

MainLoop;
