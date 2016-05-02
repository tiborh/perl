#!/opt/ActivePerl-5.18/bin/perl

use warnings;
use 5.014;
use utf8;
use autodie;

use lib '/home/etibhar/opt/pdi/current/utils/pdi/lib';
use lib '/home/etibhar/opt/pdi/current/utils/eriutl';

use pdi_user;

my $info = user("-uid","etibhar");
print($info)
