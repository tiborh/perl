package firstClass v0.0.2
{
    use Moose;

    sub testMethod {
	my $self = shift;
	print "testMethod has been called\n";
	my @theCaller = caller();
	print "Caller: @theCaller\n";
    }
}
1;
