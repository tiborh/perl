#!/bin/sh
#: update the LWP book zip
#==========================================================================

set -e 
cd
zip -u -r temp/lwpbook.zip ./lwpbook -x '*~*'
