package MySimple v0.0.8 {
    my $_ID = 0;
    sub new {
	my $invocant = shift;
	my $class = ref($invocant) || $invocant;
	my $self = {@_};
	$self->{"_OID"} = ++$_ID;
	return bless $self, $class;
    }

    sub getVal {
	my $self = shift;
	my $theKey = shift;
	return if $theKey =~ /_.*/;
	if (exists($self->{$theKey}) and defined($self->{$theKey})) {
	    return $self->{$theKey};
	}
	return;
    }

    sub getKeys {
	my $self = shift;
	my @outarray = ();
	foreach (sort keys %$self) {
	    push @outarray,$_ unless /_.*/;
	}
	return @outarray;
    }

    sub setVal {
	my $self = shift;
	my $theKey = shift || return;
	my $theVal = shift || return;
	return if $theKey =~ /_.*/;
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
	return if $oldKey eq "_OID";
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

    sub getID {
	my $self = shift;
	my $theID = shift || "_OID";
	return $self->{$theID};
    }

    sub printSelf {
	binmode(STDOUT, ":utf8");
	my $self = shift;
	my $line_start = shift || "";
	print "$line_start$_ => ",$self->{$_},"\n" foreach (sort keys %$self);
	return;
    }
}
1;
