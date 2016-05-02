#!/opt/ActivePerl-5.18/bin/perl
use strict; use warnings;

use lib 'pdi/current/utils/pdi/lib';
use lib 'pdi/current/utils/eriutl';

use pdi_user;

my $DEBUG = 0;

print "Content-type:text/html\r\n\r\n";
print '<html>',"\n";
print '<head>',"\n";
print "\t",'<meta http-equiv="Content-Type" content="text/html" charset="utf-8" />',"\n";
print "\t",'<title>User Info</title>',"\n";
print '</head>',"\n";
print '<body>',"\n";
print "\t",'<h1>User Info</h1>',"\n";
my $uid = &get_env_var();
if ($uid !~ /[a-zA-z]{5,7}/)
{
    print "\t<p>Invalid user ID: $uid</p>\n";
}
else
{
    my $the_data = &get_the_data($uid);
    if (length($the_data)<8)
    {
	print "\t<p>invalid data: '$the_data'</p>\n";
    }
    else
    {
	&print_the_data_table($the_data);
    }
}
print '</body>',"\n";
print '</html>',"\n";

sub get_env_var {
    my ($buffer, @pairs, $pair, $name, $value, %FORM);
# Read in text
    if (!defined($ENV{'REQUEST_METHOD'}))
    {
	print("\t<p>No CGI environment has been found.</p>\n");
	return("no ID");
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

sub get_the_data
{ 
    my $the_uid = shift;
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

sub print_the_data_table
{
    my $input_data = shift;
    my @data_lines = split(/\n/,$input_data);
    my @the_fields = split(/\t/,$data_lines[0]);
    my @the_data = split(/\t/,$data_lines[1]);
	print "\t<table>\n";
	foreach my $i (0..$#the_fields)
	{
	    print "\t\t<tr>\n";
	    print "\t\t\t<td>$the_fields[$i]</td>\n";
	    print "\t\t\t<td>$the_data[$i]</td>\n";
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
