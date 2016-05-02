#!/usr/bin/perl -w
use strict;
use utf8;
binmode STDOUT, ":utf8";

sub main {
    {
	my $message_text = "Test message\n";
	my $subject_text = "Test mail\n";
	print "<h1>Testing sendmail</h1>\n";
	print "<p>subject: $subject_text</p>\n";
	print "<p>message: $message_text</p>\n";
	($message_text = $message_text) =~ s/<[^>]*>//gs;
	my @rudewords = qw(fuck shit);
	my $rude = "no";
	foreach my $word (@rudewords) {
	    if ($message_text =~ m/$word/gi or $subject_text =~ m/$word/gi) {
		$rude = "yes";
	    }
	}

	unless ($rude eq "yes") {
	    open(MAIL, '| /usr/sbin/sendmail -t -oi');
	    print MAIL <<EOF;
To: tibor
From: tibor
Subject: $subject_text

$message_text
EOF
	  
	  close MAIL;
	}

	print "<p>Thanks for your email!</p>\n";

    }
}


&cgi_head("sendmail");
&main();
&cgi_foot();
exit;

sub cgi_head {
print <<"EOT";
Content-type: text/html\n
<!doctype html>
<html lang="en">
<head>
\t<meta charset="utf-8">
\t<title>$_[0]</title>
</head>
<body>
EOT
}

sub cgi_foot {
print <<"EOT";
</body>
</html>
EOT
}
