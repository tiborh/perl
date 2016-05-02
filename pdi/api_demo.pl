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
  my($csv_out)= pdi_lsis::get('Cout'); ### same as pdi_lsis::get('Out');
  ### May get many different output format:
  ### Xout: Reformatted XML converted to ISO8859-1 [-CharSet 8859-1 (by default)]
  ### xout: Received xml
  ### Tout: TSV ...
  ### ... See pdi man xml_rd for more info ...
  
  ### '$lsis_h' is a HASH reference of the 'lsis' local variables
  ### my($lsis_h)= pdi_lsis::get();  print(cpws::dataDump($lsis));
  return( split(/[\r\n]+/, $csv_out) ); 
}

# sub SameSubRoutine
# { 
#     my($errflg, @args)= (undef, (qw(-pno LZN9011398/2 -rst R5A -csv_hd_flds),
# 			       'ChildNoE,ChildRevision,ChildLanguage,DocTitle',
# 			       qw(-outf NUL -env Prod -csv_quote_ifreq -csv_noheader) );
# 			 die("Command \"pdi lsis '".join("', '",@args)."'\" failed with rc:$errflg\n")
# 			 if($errflg= lsis(@args));
# 			 return(split(/[\r\n]+/,pdi_lsis::get('Cout'))));
# }

  print("SomeSubRoutine(): {\n\t".join("\n\t",SomeSubRoutine())."\n}\n");
  #print("SameSubRoutine(): {\n\t".join("\n\t",SameSubRoutine())."\n}\n");
