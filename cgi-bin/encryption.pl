#!/usr/bin/perl -w
use strict;
use utf8;
binmode STDOUT, ":utf8";

my $title = "Encryption with crypt function";

sub main {
    print <<EOT;
<h1>$title</h1>
<p>One way process. Strings can be crypted with the function.</p>
<p>The salt is the first two characters of the encrypted text.</p>
EOT

my $password = "mypassword";
    my $encrypted = crypt $password, "pW"; # two character, salt, any two characters
    print "<p>Encrypted text: $encrypted</p>\n";
    $encrypted = crypt $password, join '', ('.', '/', 0..9, 'A'..'Z', 'a'..'z')[rand 64, rand 64];
    print "<p>Encrypted text with random salt: $encrypted</p>\n";
    $encrypted = crypt $password, join '', ('.', '/', 0..9, 'A'..'Z', 'a'..'z')[rand 64, rand 64];
    print "<p>Encrypted text with random salt (second run): $encrypted</p>\n";

    # Usage example:
    # my $salt = substr($encrypted, 0, 2);

    # print "Enter your password.\n";
    # while (<>) {
    # 	if ($encrypted eq (crypt $_, $salt)) {
    # 	    print "Logged in!\n"; 
    # 	    exit;
    # 	} else {
    # 	    print "Password incorrect.\n";
    # 	}
    # }

} # main

require "html.cgi";

&cgi_head("$title");
&main();
&printcode($0);
&cgi_foot();
exit;
