#!/usr/bin/env perl

use strict;
use warnings;
use LWP::UserAgent;

my $ua = LWP::UserAgent->new;
$ua->env_proxy;
$ua->protocols_allowed(['https']);

my $URI = 'https://www.somemonks.org';
my $request = HTTP::Request->new(GET => $URI);
$request->authorization_basic('user', 'pass');

my $response = $ua->request($request);
if ($response->is_success) {
    print $response->decoded_content;
}
else {
    die $response->status_line;
}
