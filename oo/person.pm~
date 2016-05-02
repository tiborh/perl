package Person v0.0.2 {
    use Carp;

    sub new {
	my $class = shift;
	my $self = {
	    _firstName => shift,
	    _lastName  => shift,
	    _ssn       => shift,
	};
	bless $self, $class;
	return $self;
    }

    sub getFirstName {
	my $self = shift;
	return $self->{_firstName};
    }

    sub setFirstName {
	my ( $self, $firstName ) = @_;
	if (defined($firstName)) {
	    $self->{_firstName} = $firstName;
	    return 0;
	} else {
	    return 1;
	}
    }
    
    sub getLastName {
	my $self = shift;
	return $self->{_lastName};
    }

    sub setLastName {
	my ( $self, $lastName ) = @_;
	if (defined($lastName)) {
	    $self->{_lastName} = $lastName;
	    return 0;
	} else {
	    return 1;
	}
    }
    
    sub getSSN {
	my $self = shift;
	return $self->{_ssn};
    }

    sub setSSN {
	my ( $self, $ssn ) = @_;
	if (defined($ssn)) {
	    $self->{_ssn} = $ssn;
	    return 0;
	} else {
	    return 1;
	}
    }
    
    sub print {
	my $self = shift;
	print $_," => ",$self->{$_},"\n" foreach (sort keys %$self);
    }

    sub DESTROY {
	my $self = shift;
	my $type = ref ($self);
	print "   $type","::DESTROY called\n";
    }
    
    sub AUTOLOAD {
	my $self = shift;
	my $type = ref ($self) || croak "$self is not an object";
	my $field = $AUTOLOAD;
	$field =~ s/.*://;
	unless (exists $self->{$field})	{
	    croak "'$field' method does not exist in object/class $type";
	}
	if (@_)	{
	    return $self->($name) = shift;
	} else {
	    return $self->($name);
	}
    }
}
1;
