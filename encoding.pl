#!/usr/bin/perl -w

use strict;

#to find out what encodings are supported, run:
# perl -MEncode -le "print for Encode->encodings(':all')"

my $stxt = "Árvíztűrő tükörfúrógép.\n";
my $fh;	
my $fmw = ">";
my $fmr = "<";
my %filenames = (		# commented out ones did not work at all
    'fnu8' => 'encoding_utf8.txt',
    'fnu16' => 'encoding_utf16.txt',
    'fn1' => 'encoding_iso8859-1.txt',
    'fn15' => 'encoding_iso8859-15.txt', # 1 error: ü
#    'fn2' => 'encoding_iso8859-2.txt',
#    'fn852' => 'encoding_cp852.txt',
#    'fn1250' => 'encoding_cp1250.txt',
    'fn1252' => 'encoding_cp1252.txt', # 2 errors: Á & ő
#    'fnMacCE' => 'encoding_MacCE.txt',
#    'fnAdStd' => 'encoding_AdStd.txt',
    );
my %encodings = (
    'fnu8' => 'utf8',
    'fnu16' => 'UTF-16',
    'fn1' => 'iso-8859-1',
    'fn15' => 'iso-8859-15',
#    'fn2' => 'iso-8859-2',
#    'fn852' => 'cp852',
#    'fn1250' => 'cp1250',
    'fn1252' => 'cp1252',
#    'fnMacCE' => 'MacCentralEurRoman',
#    'fnAdStd' => 'AdobeStandardEncoding',
    );

print("Starting writing session.\n");
foreach my $key (keys %filenames) {
    my $fmwe = $fmw . ":encoding($encodings{$key})";
    open($fh,$fmwe,$filenames{$key}) or die print("Unable to open file $filenames{$key} for writing, $!");
    print($fh $stxt);
    close($fh);
    printf("File written: %s\n",$filenames{$key});
}
print("Writing session: finished.\n");
print("Starting reading session.\n");
foreach my $key (keys %filenames) {
    printf("File to read: %s\n",$filenames{$key});
    my $fmre = $fmr . ":encoding($encodings{$key})";
    open($fh,$fmre,$filenames{$key}) or die print("Unable to open file $filenames{$key} for writing, $!");
    my $line = <$fh>;
    print($line);
    close($fh);
}
print("Writing session: finished.\n");
