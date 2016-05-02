package Simplest v0.0.6 {
    my $_ID = 0;
    my $_private = sub { print "A _private() method has been called.\n"; };
    sub new {
	my $self = {};
	$self->{_ID} = $_ID++;
	bless $self;
	return $self;
    }
    sub version {
	my $self = shift;
	return $self->VERSION;
    }
    sub getID {
	my $self = shift;
	return $self->{_ID};
    }
    sub callPrivate {
	$_private->();
    }
}
1;
