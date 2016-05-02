#!/opt/ActivePerl-5.18/bin/perl
use strict; use warnings;

# for cgi-bin:
#use lib 'pdi/current/utils/pdi/lib';
#use lib 'pdi/current/utils/eriutl';

# for command line:
use lib '/home/etibhar/opt/pdi/current/utils/pdi/lib';
use lib '/home/etibhar/opt/pdi/current/utils/eriutl';

use pdi_mkrstate;

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

my @prod_nums = ("CXP 903 0593/3", # Probe
		"CXP 903 1531/3", # Corr & Adapters
		"CXP 903 1564/3", # BL
		"CXP 903 0698/3", # GUI
		"CXP 903 1532/3", # Offline
		"CXP 903 1593/3" # MapR
    );

my @prod_nums_new = (
		     #"CXP 903 2357/3", # Platform
		     "CXP 903 2427/3", # DQM GUI
		     "CXP 903 2359/3" # DQM Platform
    );

#&create_rstate("CXP 903 2357/3","R1C","R1B")

#print foreach @doc_nums;
#&create_rstate($_,"R2B","R2A") foreach @prod_nums;
#&create_rstate($_,"R1B","R1A") foreach @prod_nums_new;

&create_rstate($_,"P2B","P2A") foreach @prod_nums;
&create_rstate($_,"P1B","P1A") foreach @prod_nums_new;
&create_rstate("CXP 903 2357/3","P1C","P1B");

sub create_rstate()
{
    my($errflg);
    my $product_number = shift;
    my $rstate = shift;
    my $rstate_old = shift;

    if($errflg= mkrstate( '-pno', "$product_number",
			  '-rst', "$rstate",
			  '-prst', "$rstate_old"
     ) )
    { die("Command 'pdi mkrstate()' failed with rc:$errflg\n"); }

    return(1);
}

#pdi mkrstate -pno "" -rst R2A -prst R2B

