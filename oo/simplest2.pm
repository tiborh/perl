package Simplest v0.0.4 {
    sub new {
	my $self = {};	
	bless $self;
	return $self;
    }
    sub version {
	my $self = shift;
	return $self->VERSION;
    }
}
1;
