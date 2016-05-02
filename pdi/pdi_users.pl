#!/opt/ActivePerl-5.18/bin/perl
use strict; use warnings;

use lib 'pdi/current/utils/pdi/lib';
use lib 'pdi/current/utils/eriutl';

use pdi_user;

my $DEBUG = 0;

my $html_top = << "EOM";
Content-type:text/html\r\n\r
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html" charset="utf-8" />
    <title>User Info</title>
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
    <h1>User Info</h1>
EOM
    print $html_top;
&do_the_magic();
print '</body>',"\n";
print '</html>',"\n";

sub do_the_magic
{
    my $uids = &get_env_var();
#print "<p>The uid string: $uids</p>\n";
    my @proced_uids = &process_uid_str($uids);
#print "<p>Processed uid string: @proced_uids</p>\n";
    my @raw_results = &process_uid_arr(@proced_uids);
#print "<p>Raw results: @raw_results</p>\n";
    my @preproced_results = &pre_proc_results(@raw_results);
#print "<p>Pre-processed results: @preproced_results</p>\n";
    print_the_data_table(@preproced_results);
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

sub process_uid_str
{
    my $uids = shift;
    return "" if (length($uids) == 0);
    my @uidarr = split(/\s+/,$uids);
    return(@uidarr);
}

sub process_uid_arr
{
    return "" if (scalar(@_) == 0);
    #my @uid_arr = @$uids;
    my @results = ();
    foreach my $a_uid (@_)
    {
	push(@results,&get_user_data($a_uid));
    }

    return(@results);
}

sub get_user_data
{ 
    my $the_uid = shift;
    if ($the_uid !~ /[a-zA-Z][a-zA-z0-9]{4,8}/)
    {
	print "\t<p>Invalid user ID: $the_uid</p>\n";
	return("");
    }
    my($errflg);
    if($errflg= user( '-uid', "$the_uid",
		      '-ofmt','Tout',
		      # '-csv_hd_flds', 'PrNoESub,PrRevESub,PrRevEChSub,ReleaseCodeSub,DesignCodeSub,LevelNo,PStrTypeSub1,PStrRevESub1,VERSIONDESIGNTXT,DESRESPO,RELRESPO',
		      qw(-outf NUL),
		    ### '-outf', 'NUL', '-env', 'Prod', '-csv_quote_ifreq', '-csv_noheader',
     ) )
  { return($errflg); }
    my($dat_out)= pdi_user::get('Tout');

  return($dat_out)
}

sub pre_proc_results
{
    return "" if scalar(@_) == 0;
    my @proced_results = ();
    my $header;
    foreach my $an_item (@_)
    {
	my @data_lines = split(/\n/,$an_item);
	if (!defined($header))
	{
	    $header = $data_lines[0];
	    push(@proced_results,$header);
	}
	push(@proced_results,$data_lines[1]);
    }
    return(@proced_results);
}

sub print_the_data_table
{
    return "" if scalar(@_) == 0;
    my $isheader = 1;
    print "\t<table>\n";
    foreach my $a_line (@_)
    {
	print "\t\t<tr>\n";
	my @the_line = split(/\t/,$a_line);
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
		print "\t\t\t<td>$a_field</td>\n";
	    }
	}
	print "\t\t</tr>\n";
    }
    print "\t</table>\n";
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
