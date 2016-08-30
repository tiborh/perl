package TestTools v0.0.1 {
    use Carp;
    use v5.14;
    use warnings;

    sub print_head() {
	my $testname = shift || "";
	state $i = 1;
	my $prefix = "Test $i -- ";
	my $width = length($prefix) + length($testname) ;
	say "";
	say "=" x $width;
	say "$prefix$testname";
	say "=" x $width;
	++$i;
	return 1;
    }
}
1;
