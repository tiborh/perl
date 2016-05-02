#!/opt/ActivePerl-5.18/bin/perl
use strict; use warnings;

use lib 'pdi/current/utils/pdi/lib';
use lib 'pdi/current/utils/eriutl';

use pdi_lsprod;
use pdi_login;

my $DEBUG = 0;

my $html_top = << "EOM";
Content-type:text/html\r\n\r
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html" charset="utf-8" />
    <title>Product Info</title>
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
    <h1>Product Info</h1>
EOM
    print $html_top;
my $magic_result = &do_the_magic();
print "<p>Product number string is too short.</p>\n" if ($magic_result == 1);
print "<p>Problem with authentication.</p>\n" if ($magic_result == 2);
print '</body>',"\n";
print '</html>',"\n";

sub do_the_magic
{
    $ENV{"HOME"} = ".";
    use Carp qw(cluck);
    my $prodnum = &get_env_var();
#print "<p>The prodnum string: $prodnum</p>\n";
    return(1) if (length($prodnum) < 8);
    my ($cookie_result,$uid,$pwd) = &read_cookie_data();
    return(2) if length($cookie_result) == 1;
    if (&perform_login())
    {
	print "<p>Authentication problem (2).</p>\n";
	return(3);
    }
    my $raw_results = &get_prod_data($prodnum);
    if (length($raw_results) == 1)
    {
	cluck "<p>This is how we got here!</p>\n";
	#use File::ReadBackwards;
	#my $backwards = File::ReadBackwards->new( '/var/log/apache2/error.log' );
	#my $last_nonblank_line = $backwards->readline;
	#print "<p>$last_nonblank_line</p>\n";
	print "<p>See the server logs for further details.</p>\n";
    }
    else
    {
	#print "<p>Raw data: $raw_results</p>\n";
	my @results = split(/\n/,$raw_results);
	print_the_doc_table(@results);
    }
    return(0);
}

sub read_cookie_data
{
  my $rcvd_cookies = $ENV{'HTTP_COOKIE'};
  my @cookies = split /;/, $rcvd_cookies;
  my $user_id;
  my $password;
  my @return_dat = ();
  foreach my $cookie ( @cookies ){
     my ($key, $val) = split(/=/, $cookie); # splits on the first =.
     $key =~ s/^\s+//;
     $val =~ s/^\s+//;
     $key =~ s/\s+$//;
     $val =~ s/\s+$//;
     if( $key eq "PdiRacfUserID" ){
        $user_id = $val;
     }elsif($key eq "PdiRacfPassword"){
        $password = $val;
     }
  }
  if (!defined($user_id))
  {
      print "<p>User is unknown.</p>\n";
      push(@return_dat,1);
      return(@return_dat);
  }
  if (!defined($password))
  {
      print "<p>auth problem</p>\n";
      push(@return_dat,2);
      return(@return_dat);
  }
  if (length($user_id) < 5)
  {
      print "<p>Stored userinfo is unsuitable.</p>\n";
      push(@return_dat,3);
      return(@return_dat);
  }

  push(@return_dat,0,$user_id,$password);

  return(@return_dat);
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
    if ($ENV{'REQUEST_METHOD'} eq "GET")
    {
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
    return($FORM{message});
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

sub get_prod_data
{ 
    my $the_input = shift;
    return "" if (length($the_input) == 0);
    my($errflg);
    if($errflg= lsprod( '-pno', "$the_input",
		      '-ofmt','Tout',
		      # '-csv_hd_flds', 'PrNoESub,PrRevESub,PrRevEChSub,ReleaseCodeSub,DesignCodeSub,LevelNo,PStrTypeSub1,PStrRevESub1,VERSIONDESIGNTXT,DESRESPO,RELRESPO',
		      qw(-outf NUL),
		    ### '-outf', 'NUL', '-env', 'Prod', '-csv_quote_ifreq', '-csv_noheader',
     ) )
  { return($errflg); }
    my($dat_out)= pdi_lsprod::get('Tout');

  return($dat_out)
}

sub print_the_doc_table
{
    return "" if scalar(@_) == 0;
    my $isheader = 1;
    my $docnumber = "";
    my $numindex = 1;
    my $langindex = 5;
    my $revindex = 3;
    my $linecounter = 0;
    print "\t<table>\n";
    foreach my $a_line (@_)
    {
	print "\t\t<tr>\n";
	my @the_line = split(/\t/,$a_line);
	if (!$isheader)
	{
	    $linecounter++;
	    $the_line[$numindex] =~ s/^"(.*)"$/$1/;
	    $docnumber = sprintf("%s U%s %s",$the_line[$numindex],$the_line[$langindex],$the_line[$revindex]);
	}
	if ($isheader)
	{
	    foreach my $a_field (@the_line)
	    {
		print "\t\t\t<th>$a_field</th>\n";
	    }
	    $isheader = 0;
	}
	else
	{
	    foreach my $a_field (@the_line)
	    {
		$a_field =~ s/^"(.*)"$/$1/;
		if ($a_field =~ /^\s*URL:http[s]?:\/\//)
		{
		    my $findstring = $a_field;
		    $findstring =~ s/^.*Find\?DocNo=(.*)/$1/;
		    $a_field =~ s/^\s*URL://;
		    print "\t\t\t<td><a href='$a_field'>Find: $findstring</a></td>\n"
		}
		elsif ($a_field =~ /^http[s]?:\/\//)
		{
		    print "\t\t\t<td><a href='$a_field'>$docnumber</a></td>\n"
		}
		else
		{
		    print "\t\t\t<td>$a_field</td>\n";
		}
	    }
	}
	print "\t\t</tr>\n";
    }
    print "\t</table>\n";
    print "\t<p>Number of lines: $linecounter</p>\n";
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
