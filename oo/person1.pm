package Person v0.0.1;
sub new
{
    my $class = shift;
    my $self = {};
    bless $self, $class;
    return $self;
}
1;
