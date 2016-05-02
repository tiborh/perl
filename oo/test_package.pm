package TestPackage v0.0.2 {
    use v5.14;
    sub list_package_vars {
	no strict 'refs';
	my $test_pack = shift;
	say "$test_pack:";
	foreach my $symbol (keys %{"$test_pack\::"}) {
	    local *sym = *{"$test_pack\::$symbol"};
	    if (defined(*sym{SCALAR})) {
		say "\tscalar $symbol == ",${*sym{SCALAR}} if ${*sym{SCALAR}};
	    }
	    if (defined(*sym{ARRAY})) {
		say "\tarray $symbol == ",@{*sym{ARRAY}} if @{*sym{ARRAY}};
	    }
	    if (defined(*sym{HASH})) {
		say "\thash $symbol == ",%{*sym{HASH}} if %{*sym{HASH}};
	    }
	    if (defined(*sym{IO})) {
		say "\tIO $symbol";
	    }
	    if (defined(*sym{FORMAT})) {
		say "\tFORMAT $symbol";
	    }
	    if (defined(*sym{CODE})) {
		say "\tsub $symbol";
	    }
	}
	if (@{"$test_pack\::ISA"}) {
	    say "Has parent(s): ",@{"$test_pack\::ISA"};
	    list_package_vars($_) foreach (@{"$test_pack\::ISA"});
	}
	return;
    }
}
1;
