package TimeStamp v0.0.1 {
    use Carp;
    use v5.14;
    no warnings 'experimental::smartmatch';
    use vars qw($AUTOLOAD $name);

    sub new {
	my $class = shift;
	my $self = {
	    _timestamp => TS::ts(),
	};
	bless $self,$class;
	return $self;
    }

    sub setter {
	my $self = shift;
	$self->{_timestamp} = TS::ts();
    }
    
    sub getter {
	my $self = shift;
	return $self->{_timestamp};
    }

    sub _print_self {
	my $self = shift;
	print "timestamp: ",$self->{_timestamp},"\n";
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
package TS v0.0.1 {
    sub ts {	
	my @art = localtime(time);
	return sprintf("%4d%02d%02d_%02d%02d%02d",
		       $art[5]+1900, # year
		       ++$art[4],    # month
		       $art[3],      # day
		       $art[2],      # hour
		       $art[1],      # minute
		       $art[0]);     # second
    }
}
1;
