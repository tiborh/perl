package Bug;

sub new {
    my $class = $_[0];
    my $objref = {
	_id=> $_[1],
	_type=> $_[2],
	_descr=> $_[3],
    };
    bless $objref, $class;
    return $objref;
}

sub print_me {
    my ($self) = @_;
    print "ID: $self->{_id}\n";
    print "$self->{_descr}\n";
    print "(Note: problem is fatal)\n"
	if $self->{_type} eq "fatal";
}

1;
