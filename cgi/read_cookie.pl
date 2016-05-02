#!/usr/bin/env perl

  $rcvd_cookies = $ENV{'HTTP_COOKIE'};
  @cookies = split /;/, $rcvd_cookies;
  foreach $cookie ( @cookies ){
     ($key, $val) = split(/=/, $cookie); # splits on the first =.
     $key =~ s/^\s+//;
     $val =~ s/^\s+//;
     $key =~ s/\s+$//;
     $val =~ s/\s+$//;
     if( $key eq "UserID" ){
        $user_id = $val;
     }elsif($key eq "Password"){
        $password = $val;
     }
  }

print "Content-type:text/html\r\n\r\n";

print '<meta http-equiv="Content-Type" content="text/html" charset="utf-8" />';
print "<html>\n";
print "<head>\n";
print "\t<title>Read Cookie</title>\n";
print "</head>\n";
print "<body>\n";
print "\t<h2>Reading Cookie</h2>\n";
print "\t<p>User ID  = $user_id</p>\n";
print "\t<p>Password = $password</p>\n";
print "</body>\n";
print "</html>\n";

