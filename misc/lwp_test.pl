#!/usr/bin/perl -w
use strict;
# Create a user agent object
  use LWP::UserAgent;
  my $ua = new LWP::UserAgent;
  $ua->agent("AgentName/0.1 " . $ua->agent);

  # Create a request
  my $req = new HTTP::Request POST => 'http://www.perl.com/cgi-bin/BugGlimpse';
  $req->content_type('application/x-www-form-urlencoded');
  $req->content('match=www&errors=0');

  # Pass request to the user agent and get a response back
  my $res = $ua->request($req);

  # Check the outcome of the response
  if ($res->is_success) {
      print $res->content;
  } else {
      print "Bad luck this time\n";
  }
