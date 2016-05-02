#!/usr/bin/perl -w

use strict;
use Tk;
require Tk::NoteBook;
use utf8;
use encoding 'utf8';

my $mw = MainWindow->new( );

# Create the notebook and fill the whole window
my $nb = $mw->NoteBook( )->pack(-expand => 1, -fill => 'both');

# tab 1
my $tab1_txt = "Hamlet";
my $tab1 = $nb->add($tab1_txt, -label => $tab1_txt);

my $sample_text = $tab1->Scrolled("Text",-scrollbars => 'ow');
$sample_text->configure(-wrap => 'word');
$sample_text->pack(-expand => 1, -fill => 'both');

my $FH;
my $FN = $ARGV[0] ? $ARGV[0] : "textbox.txt";
my $FM = "<";
open($FH,$FM,$FN) || die "Could not open $FN: $!";
$sample_text->insert('end',$_) while (<$FH>);
close $FH;

$sample_text->configure(-state => 'disabled');

# tab 2
my $tab2_txt = "Jaques";
my $tab2 = $nb->add($tab2_txt, -label => $tab2_txt);
my $sample_text2 = $tab2->Scrolled("Text",-scrollbars => 'ow');
$sample_text2->configure(-wrap => 'word');
$sample_text2->pack(-expand => 1, -fill => 'both');

$FN = $ARGV[1] ? $ARGV[1] : "textbox2.txt";
open($FH,$FM,$FN) || die "Could not open $FN: $!";
$sample_text2->insert('end',$_) while (<$FH>);
close $FH;

$sample_text->configure(-state => 'disabled');

MainLoop;
