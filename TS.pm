package TS v0.0.1 {
    use Carp;
    use v5.14;
    no warnings 'experimental::smartmatch';

    sub ts {	
	my @art = localtime(time);
	return sprintf("%4d%02d%02d_%02d%02d%02d",
		       $art[5]+1900, # year
		       ++$art[4],    # month
		       $art[3],      # day
		       $art[2],      # hour
		       $art[1],      # minute
		       $art[0]);     # second
    }
}
1;
