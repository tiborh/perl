package MySimple v0.0.4 {
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

    sub getKeys {
	my $self = shift;
	return (sort keys %$self);
    }

    sub printSelf {
	my $self = shift;
	my $line_start = shift || "";
	print "$line_start$_ => ",$self->{$_},"\n" foreach (sort keys %$self);
	return;
    }
}
1;
