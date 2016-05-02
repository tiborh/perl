package Autoload_Example v0.0.1 {
    use v5.14;
    no strict "refs"; 		# to avoid: Can't use string ... as a symbol ref while "strict refs"
    sub AUTOLOAD {
	my $name = our $AUTOLOAD;
	*$AUTOLOAD = sub { say "Function called '$name(@_)' has not been defined."; };
	goto &$AUTOLOAD;	# restart the new routine
    }
}
1;
