package Simplest v0.0.5 {
    my $_ID = 0;
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
}
1;
