#!/usr/bin/env perl

use warnings;
use v5.14; 			# implies strict
use Carp;
use utf8;
use autodie;
#the following two needs installation:
#use Modern::Perl;
#use Test::More;

binmode(STDOUT, ":utf8");

use Gtk2 -init;
# Gtk2->init; works if you didn't use -init on use
my $window = Gtk2::Window->new ('toplevel');
my $button = Gtk2::Button->new ('Quit');
$button->signal_connect (clicked => sub { Gtk2->main_quit });
$window->add ($button);
$window->show_all;
Gtk2->main;
