#!/usr/bin/perl -w

use strict;
use Tk;
use utf8;
use encoding 'utf8';

# Main Window
my $mw = MainWindow->new;
$mw->title("Textbox");
#$mw->minsize(qw(275 150));

# Scroll bar
my $sample_scroll = $mw->Scrollbar();

# Text box (-yscrollcommand is one end of the bind)
my $sample_text = $mw->Text(-wrap => 'word',-yscrollcommand => ['set', $sample_scroll])->pack(-expand => 1, -fill => 'both');

# the second end of the bind: scrollbar to text
$sample_scroll->configure(-command => ['yview' => $sample_text]);
$sample_scroll->pack(-before => $sample_text,-side => 'left', -fill => 'both');

# File handling
my $FH;
my $FN = $ARGV[0] ? $ARGV[0] : "textbox.txt";
my $FM = "<";

open($FH,$FM,$FN) || die "Could not open $FN: $!";

# Display
$sample_text->insert('end',$_) while (<$FH>);

# No modification by user
$sample_text->configure(-state => 'disabled');

MainLoop;
