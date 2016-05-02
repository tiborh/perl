#!/usr/bin/perl -w
use strict;
use utf8;
binmode STDOUT, ":utf8";

use CGI;

#my %params = (); #later this can be made equal to %{$cgi->Vars()}
$CGI::POST_MAX = 100 * 1024; 	# max 100kB of filesize
$CGI::DISABLE_UPLOADS = 0;	# 1 disables uploads
my $Referer = $ENV{HTTP_REFERER};
my $Domain = "localhost";

my $cgi = new CGI;

my $file = $cgi->upload('image');

print $cgi->header,
    $cgi->start_html(
	-title=>'CGI.pm File Upload'
    );

print <<EOF;
<form action="" method="post" enctype="multipart/form-data">
<input type="file" name="image" size="40" /><br />
<input type="submit" value="Upload" />
</form>
EOF

    if ($file) {
	if ($Referer =~ "$Domain") {
	    my $directory = "/var/www/uploads/"; # directory must be at least group-writable
	    open UPLOAD, ">", "$directory$file" or die "Cannot open $directory$file, $!";
	    binmode UPLOAD;
	    print UPLOAD while (<$file>);
	    close UPLOAD;
	    print "<p><img src=\"http://localhost/uploads/$file\" /></p>\n";
	}
}

print $cgi->end_html,"\n";

exit;
