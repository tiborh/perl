package MysqlConnexion v0.0.1 {
    use Carp;
    use warnings;
    use v5.14; 			# implies strict
    use DBI;
    use DBD::mysql;
    use vars qw($AUTOLOAD $name);
    use utf8;
    
    binmode(STDOUT, ":utf8");

    sub new {
	my $class = shift;
	state $id_counter = 0;
	my $self = {
	    _db => 'testdb',
	    _dbhost => '127.0.0.1',
	    _dbport => '3306',
	    _dbuser => 'testuser',
	    _dbuserpass => 'testpass',
	    _dbh => "",
	    @_
	};
	$self->{_id} = $id_counter++;
	bless $self,$class;
	return $self;
    }
    
    sub connect_db {
	my $self = shift;
	my $db_str = "dbi:mysql:" . $self->{_db} . ":" . $self->{_dbhost} . ":" . $self->{_dbport};
	$self->{_dbh} = DBI->connect($db_str, 
				   $self->{_dbuser}, 
				   $self->{_dbuserpass})
	    or die "Can't connect to the DB: $DBI::errstr\n";
    }

    sub db_prepare {
	my $self = shift;
	my $sql_line = shift;

	my $sql_link = $self->{_dbh}->prepare($sql_line) 
	    or die "Error:" . $self->{_dbh}->errstr . "\n";

	$sql_link->execute
	    or die "Error:" . $sql_link->errstr . "\n";

	return $sql_link;
    }

    sub db_get {
	my $self = shift;
	my $sql_line = shift;
	my $sql_link = db_prepare($self,$sql_line);
	my %collector = ();

	while(my @aline = $sql_link->fetchrow_array()) {
	    #say "aline: @aline";
	    #say "key to be: $aline[0]";
	    $collector{$aline[0]} = \@aline;
	    #push $collector,$aline;
	}
	
	return \%collector;
    }

    sub db_set {
	my $self = shift;
	my $sql_line = shift;
	my $sql_link = db_prepare($self,$sql_line);
    }
    
    sub DESTROY {
	my $self = shift;
	my $type = ref ($self);
	$self->{_dbh}->disconnect() unless $self->{_dbh} eq "";
	say "$type (",$self->{_id},"): database has been disconnected.";
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
1;
