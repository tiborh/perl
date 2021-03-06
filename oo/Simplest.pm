package Simplest v0.0.8 {
    use warnings;
    use strict;
    my $_ID = 0;
    my $_private = sub {
	my $oid = shift;
	print "\tA _private() method has been called in object $oid.\n";
	return;
    };
    sub new {
	my $class = shift;	# important for inheritance
	my $self = {};
	$self->{_ID} = $_ID++;
	bless $self,$class;
	return $self;
    }
    sub getID {
	my $self = shift;
	return $self->{_ID};
    }
    sub callPrivate {
	my $self = shift;
	$_private->($self->{_ID});
    }
}
1;
