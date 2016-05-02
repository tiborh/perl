package MySimple v0.0.3 {
    sub new {
	my $invocant = shift;
	my $class = ref($invocant) || $invocant;
	return bless {@_}, $class;
    }

    sub getVal {
	my $self = shift;
	my $skey = shift;
	my %params = %$self;
	if (exists($params{$skey}) and defined($params{$skey})) {
	    return $params{$skey};
	} else {
	    return;
	}
    }

    sub printSelf {
	my $self = shift;
	print "$_ => ",$self->{$_},"\n" foreach (sort keys %$self);
	return;
    }
}
1;
