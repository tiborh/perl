package MySimple v0.0.7 {
    binmode(STDOUT, ":utf8");
    binmode(STDERR, ":utf8");
    sub new {
	my $invocant = shift;
	my $class = ref($invocant) || $invocant;
	return bless {@_}, $class;
    }

    sub getVal {
	my $self = shift;
	my $theKey = shift;
	if (exists($self->{$theKey}) and defined($self->{$theKey})) {
	    return $self->{$theKey};
	}
	return;
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

    sub setKey {
	my $self = shift;
	my $oldKey = shift || return;
	my $newKey = shift || return;
	if (exists($self->{$oldKey})) {
	    $self->{$newKey} = $self->{$oldKey};
	    delete $self->{$oldKey};
	    return ($newKey,$self->{$newKey});
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
