package MySimple v0.0.6 {
    sub new {
	my $invocant = shift;
	my $class = ref($invocant) || $invocant;
	return bless {@_}, $class;
    }

    sub getVal {
	my $self = shift;
	my $skey = shift;
	if (exists($self->{$skey}) and defined($self->{$skey})) {
	    return $self->{$skey};
	} else {
	    return;
	}
    }

    sub getKeys {
	my $self = shift;
	return (sort keys %$self);
    }

    sub setVal {
	my $self = shift;
	my $theKey = shift || return;
	my $theVal = shift || return;
	if (exists($self->{$theKey})) {
	    $self->{$theKey} = $theVal;
	    return $theVal;
	}
	return;
    }
    
    sub addKeyVal {
    	my $self = shift;
    	my $newKey = shift || return;
    	my $newVal = shift || return;
    	unless (exists($self->{$newKey})) {
    	    $self->{$newKey} = $newVal;
    	    return ($newKey,$newVal);
    	}
    	return;
    }

    sub printSelf {
	my $self = shift;
	my $line_start = shift || "";
	print "$line_start$_ => ",$self->{$_},"\n" foreach (sort keys %$self);
	return;
    }
}
1;
