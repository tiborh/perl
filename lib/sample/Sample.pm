use v5.14; 			# implies strict

package Sample {
    $Sample::VERSION = '0.0.1';
    sub AUTOLOAD {
	print "The function $Sample::AUTOLOAD was called with parameters: ", @_ ? "@_" : "<none>";
	print "\n";
    }
}
1;
