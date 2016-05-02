use utf8;

package MyGlob v0.0.1{
    local *myGlob;
    our $myScal = 1;
    our $myArr = [1,2,3];
    our $myHash = {一 => 1, 
		  二 => 2, 
		  三 => 3,
    };
    sub myCode {
	return scalar @_;
    }
    *myGlob = \$myScal;		# should work, but it does not
    *myGlob = $myArr;		# ditto
    *myGlob = $myHash;		# ditto
    *myGlob = \&myCode;		# ditto
}
1;
