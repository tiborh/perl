#!/opt/ActivePerl-5.18/bin/perl
use strict; use warnings;

use lib '/home/etibhar/opt/pdi/current/utils/pdi/lib';
use lib '/home/etibhar/opt/pdi/current/utils/eriutl';

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
use pdi_lsis;

sub SomeSubRoutine
{ 
    my($errflg);
    if($errflg= lsis( qw(-pno LZN9011398/2 -rst R5A),
		    ###   '-pno', 'LZN 901 1398/2', '-rst', 'R5A',
		    '-csv_hd_flds', 'ChildNoE,ChildRevision,ChildLanguage,DocTitle',
		    qw(-outf NUL -env Prod -csv_quote_ifreq -csv_noheader),
		    ### '-outf', 'NUL', '-env', 'Prod', '-csv_quote_ifreq', '-csv_noheader',
     ) )
  { die("Command 'pdi lsis()' failed with rc:$errflg\n"); }
    # only good for printing and very simple processing:
    # my($csv_out)= pdi_lsis::get('Cout'); ### same as pdi_lsis::get('Out');

    # numbered keys do not look so good:
    #my($hash_out)= pdi_lsis::get('Kout'); ### same as pdi_lsis::get('Out');
    
    # flattened out does not necessarily make it simple (keys look like directory paths)
    # my($hash_out)= pdi_lsis::get('hout'); ### same as pdi_lsis::get('Out');

    # too complicated structure. not needed most of the time
    # my($hash_out)= pdi_lsis::get('Hout'); ### same as pdi_lsis::get('Out');

    my($uout)=pdi_lsis::get('Uout');

#  return( split(/[\r\n]+/, $csv_out) ); 
  return($uout)
}


my $u_out = SomeSubRoutine();

# for Kout and hout:
#foreach my $a_key (keys %$hash_out) {
#    print("$a_key: $$hash_out{$a_key}\n");
#}

use Data::Dumper;
print(Dumper($u_out));

# for Hout:
# print("..Seq.\n");
# foreach my $an_item (@{$hash_out->{"Seq."}})
# {
#     print("\t$an_item\n");
# }

# print("InfoStr:\n");

# foreach my $a_key (%{$hash_out->{"InfoStr"}})
# {
#     print("$a_key: ",$hash_out->{"InfoStr"}->{$a_key},"\n");
# }


# ..Seq.: ARRAY(0x24c6d38)
# ..xid.: 
# InfoStr: HASH(0x24c6648)
