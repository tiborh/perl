package BaseName v0.0.1 {
    use Carp;
    use v5.14;

    use TimeStamp;
    use File::Basename;

    sub get_basename {
	my $barebn = shift || 0;
	my $bn = (split /\./,basename($0))[0];
	return $bn if $barebn;
	$bn .= '_'.TS::ts();
	
	return $bn;
    }

}
1;
