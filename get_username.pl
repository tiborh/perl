#!/usr/bin/perl -w
##!/app/perl/5.8.8/bin/perl -w

use strict;

my $user_name = &get_user_name;

print (($user_name) ? "$user_name\n" : "User name was not found.\n");

sub get_user_name {
    return $ENV{"USER"} or return "";
}
