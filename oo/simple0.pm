package mySimple v0.0.2 {
    sub new {
	my $class = shift;
	my $self = {@_};
	#print "$_ => $$self{$_}\n" foreach keys %$self;
	bless $self, $class;
	return $self;
    }

    sub doIt {
	my $self = shift;
	my $skey = shift;
	my %params = %$self;
	#print "$_ => $params{$_}\n" foreach keys %params;
	#print "'$skey'\n";
	if (exists($params{$skey}) and defined($params{$skey})) {
	    return $params{$skey};
	} else {
	    return undef;
	}
    }
}
1;
