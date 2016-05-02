package Person;		      # name of the package/class
# Class for stroring data about a person
# person1.pm
use warnings;
use strict;
use Carp;

my @Everyone = ();		# class variable, to collect the instances

# when an object is created (attributes are set here):
sub new {
    my $class = shift;		# the name of the class is always sent (usu. implicitly, to help inheritance, it is best to make it dynamic
    my $self = {@_};		# attributes
    bless($self, $class);	# bless the attributes: bind them to the class
    #$Population++;		# each new object increments the class variable, bad solution for inheritance
    $self->_init;
    return $self;
}

# initialising the object (important for inheritance reasons)
sub _init() {
    my $self = shift;
    push @Everyone, $self;
}

# methods are created as functions: ...
sub get_attrib {
    return $_[0]->{$_[1]};
}

sub set_attrib {
    $_[0]->{$_[1]} = $_[2];
}

# to unify the previous two
sub attrib {
    return undef unless defined($_[1]);
    $_[0]->{$_[1]} = $_[2] if defined($_[2]);
    return $_[0]->{$_[1]};	# returning the old or new value
}

sub list_attribs {
    my $self = shift;
    my %attribs = %$self;
    print "$_ => $attribs{$_}\n" foreach (keys %attribs);
}

sub headcount { scalar @Everyone }
sub everyone { @Everyone }

# to handle unexisting methods
sub AUTOLOAD
{
   my $self = shift;
   my $type = ref ($self) || croak "$self is not an object";
   our $AUTOLOAD;
   my $field = $AUTOLOAD;
   $field =~ s/.*://;
   my $name;
   unless (exists $self->{$field})
   {
      croak "$field does not exist in object/class $type";
   }
   if (@_)
   {
      return $self->($name) = shift;
   }
   else
   {
      return $self->($name);
   }
}

# to help cleanup
sub DESTROY {
    print "nothing to destroy\n";
}

# package should tell "true"
1;
