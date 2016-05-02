#!/opt/ActivePerl-5.18/bin/perl
use strict; use warnings;

use lib 'pdi/current/utils/pdi/lib';
use lib 'pdi/current/utils/eriutl';

use pdi_login;

my $DEBUG = 0;

use POSIX qw(strftime);
use Time::Piece;

my $inseconds = time();
my $timenow = localtime($inseconds);
my $expiry_time = localtime($inseconds + 3600);
my $t = $expiry_time;
my $tzone = strftime("%Z",localtime);
my $expiry_time2 = sprintf("%s, %s %s %s",$t->fullday,$t->ymd,$t->hms,$tzone); 

my $magic_result = &do_the_magic();

print "Set-Cookie:Expires=$expiry_time;\n";
print "Set-Cookie:Domain=localhost;\n";
print "Set-Cookie:Path=/pdi;\n";

my $html_top = << "EOM";
Content-type:text/html\r\n\r
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html" charset="utf-8" />
    <title>Login</title>
    <style>
        table {
	    border-collapse: collapse;
        }
        table, th, td {
	    border: 1px solid black;
        }
</style>
</head>
<body>
    <h1>Login</h1>
EOM
    print $html_top;
print $magic_result ? "<p>FAIL</p>\n" : "<p>SUCCESS</p>\n";
print '</body>',"\n";
print '</html>',"\n";

sub do_the_magic
{
    my ($uid,$pwd) = &get_env_var();

# e.g. Tuesday, 31-Dec-2007 23:12:40 GMT

    if (!defined($uid) or !defined($pwd))
    {
	#print "<p>Invalid login.</p>\n";
	print "Set-Cookie:PdiRacfUserID=$uid;\n";
	print "Set-Cookie:PdiRacfPassword=null;\n";
	return(1);
    }
    #print "<p>The login string: $uid $pwd</p>\n";
    my $returned = &perform_login($uid,$pwd);
    if ($returned == 0)
    {
	#print("<p>login: OK\n</p>\n");
	print "Set-Cookie:PdiRacfUserID=$uid;\n";
	print "Set-Cookie:PdiRacfPassword=$pwd;\n";
    }
    else
    {
    	#print("<p>Login: NOK ($returned)</p>\n");
	print "Set-Cookie:PdiRacfUserID=null;\n";
	print "Set-Cookie:PdiRacfPassword=null;\n";
    }	

    return(0);
}

sub get_env_var {
    my ($buffer, @pairs, $pair, $name, $value, %FORM);
# Read in text
    if (!defined($ENV{'REQUEST_METHOD'}))
    {
	print("\t<p>No CGI environment has been found.</p>\n");
	return("");
    }
    
    $ENV{'REQUEST_METHOD'} =~ tr/a-z/A-Z/;
    if ($ENV{'REQUEST_METHOD'} eq "POST")
    {
        read(STDIN, $buffer, $ENV{'CONTENT_LENGTH'});
    }else {
	$buffer = $ENV{'QUERY_STRING'};
    }
# Split information into name/value pairs
    @pairs = split(/&/, $buffer);
    foreach $pair (@pairs)
    {
	($name, $value) = split(/=/, $pair);
	$value =~ tr/+/ /;
	$value =~ s/%(..)/pack("C", hex($1))/eg;
	$FORM{$name} = $value;
    }

    if (length($FORM{coid}) < 5 or length($FORM{coid}) > 9)
    {
	#print("<p>Invalid ID length.</p>\n");
	return(1);
    }
    if (length($FORM{pswd}) < 6 or length($FORM{pswd}) > 8)
    {
	#print("<p>Invalid password length.</p>\n");
	return(2);
    }
    
    return($FORM{coid},$FORM{pswd});
}

sub perform_login
{ 
    return "" if scalar(@_) < 2;
    my $uid = shift;
    my $pwd = shift;
    return "" if (length($uid) == 0) or (length($pwd) == 0);
    my($errflg);
    if($errflg= login( '-user', "$uid", '-password', "$pwd") )
    { return($errflg); }

  return(0)
}

BEGIN {
    foreach my $CCA_PDM_PKG_DIR ( $ENV{CCA_PDM_PKG_DIR},
				  '{[CCA_PDM_PKG_DIR_UX]}', '{[CCA_PDM_PKG_DIR_NT]}',
				  '/pub/is_tools/share/lib/CCA-pdm/latest',
				  'T:/share/lib/CCA-pdm/latest', 
				  '//erinas2-fan/is_tools/share/lib/CCA-pdm/latest',
				  '/view/cca_pdm_view/vobs/cc/CCA-pdm' )
    { if( defined($CCA_PDM_PKG_DIR) && -d "$CCA_PDM_PKG_DIR/utils/eriutl" )
      { unshift(@INC, "$CCA_PDM_PKG_DIR/utils/pdi/lib",
		"$CCA_PDM_PKG_DIR/utils/eriutl"); last; }
    }
};  


1;
