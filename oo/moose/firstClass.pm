package firstClass v0.0.3
{
    use Moose;

    # attributes
    has 'name' => (
	is => 'ro',
	isa => 'Str',
	default => 'Anonymous',
	);
    has 'age' => (
	is => 'ro',
	isa => 'Int',
	default => 0,
	);
    has 'writable' => (
	is => 'rw',
	default => '',
	);

    # methods
    sub testMethod {
	my $self = shift;
	print "testMethod has been called\n";
	my @theCaller = caller();
	print "Caller: @theCaller\n";
	return $self;
    }
    sub testMethod2 {
	my $self = shift;
	my @params = @_;
	print "Params:\n";
	print "\t$_\n" foreach @_;
	return $self;
    }
}
1;
