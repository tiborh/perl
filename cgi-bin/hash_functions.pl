#!/usr/bin/perl -w
use strict;
#use utf8;
#binmode STDOUT, ":utf8";

&cgi_head("hash functions");
{
    my %a_hash = qw(1 一つ 2 二つ 3 三つ 4 四つ 5 五つ 6 六つ 7 七つ 8 八つ 9 九つ 10 十);
    print("<h1>Hash functions</h1>\n");
    print("<p>the hash:<br />\n@{[%a_hash]}</p>\n");

    print("<p>Checking if 1 exists and if so whether it is defined:");
    &check_in_hash(1,\%a_hash);
    print "</p>\n";

    print("<p>Checking if 0 exists and if so whether it is defined:");
    &check_in_hash(0,\%a_hash);
    print "</p>\n";

    print("<p>Adding key 0 but leaving it undefined:<br />\n");
    $a_hash{0} = undef;
    print("Checking if 0 exists and if so whether it is defined:");
    &check_in_hash(0,\%a_hash);
    print "</p>\n";
    print("<p>the hash:<br />\n@{[%a_hash]}</p>\n");

    print("<p>Adding a value to key 0:<br />\n");
    $a_hash{0} = "零";
    print("Checking if 0 exists and if so whether it is defined:");
    &check_in_hash(0,\%a_hash);
    print "</p>\n";
    print("<p>the hash:<br />\n@{[%a_hash]}</p>\n");

    print("<p>Deleting key 0:<br />\n");
    delete($a_hash{0});
    print("Checking if 0 exists and if so whether it is defined:");
    &check_in_hash(0,\%a_hash);
    print "</p>\n";
    print("<p>the hash:<br />\n@{[%a_hash]}</p>\n");

    {
	print("<p>Reversing the hash:</p>\n");
	my %reversed_hash = reverse(%a_hash);
	print("<p>the hash:<br />\n@{[%reversed_hash]}</p>\n");
    }
    
    {
	print("<p>Creating a second hash:</p>\n");
	my %another_hash = (11 => "十余り一つ", 
			    20 => "廿（はたち）", 
			    30 => "卅（みそじ）",
			    40 => "四十",
			    50 => "五十",
			    60 => "六十",
			    70 => "七十",
			    80 => "八十",
			    90 => "九十",
			    100 => "百（もも）");
	print("<p>the hash:<br />\n@{[%another_hash]}</p>\n");
	print("<p>Merging the two hashes:</p>\n");
	my %merged_hash = (%a_hash,%another_hash);
	print("<p>the hash:<br />\n@{[%merged_hash]}</p>\n");
    }
}

&cgi_foot();
exit;

sub check_in_hash {
    my $key_to_check = $_[0];
    my %a_hash = %{$_[1]};
    if (exists $a_hash{$key_to_check}) {
	print "<br />\nkey $key_to_check exists";
	if (defined $a_hash{$key_to_check}) {
	    print "<br />\nkey $key_to_check is defined";
	} else {
	    print "<br />\nkey $key_to_check is not defined";
	}
    } else {
	print "<br />\nkey $key_to_check does not exist";
    }
}

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
