#!/usr/bin/perl -w

use strict;
use Tk;
use utf8;
use encoding 'utf8';

# Main Window
my $mw = MainWindow->new;
$mw->title("Textbox");
#$mw->minsize(qw(275 150));

# text box created with Scrolled method
my $sample_text = $mw->Scrolled("Text",-scrollbars => 'ow');

# text box is configured and packed
$sample_text->configure(-wrap => 'word');
$sample_text->pack(-expand => 1, -fill => 'both');

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
