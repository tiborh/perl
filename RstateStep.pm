use warnings;
use strict;
package RstateStep v0.0.1 {
    my $regex_str = '^([PR])([1-9][0-9]*)([A-Z]+)((?:[0-9]{2})|(?:\/[1-9][0-9]*))*$';
    sub stepRst {
	my $rst = shift || return;
	my $sm = shift || return; # stepping mode: major or minor
	my %modes = ( ma => 1, mi => 1);
	return unless checkRst($rst);
	my $nrst = "";
	use Switch;
	switch ($sm) {
	    case /mi/i { return stepMinor($rst); }
	    case /ma/i { return stepMajor($rst); }
	    case /ep/i { return stepEp($rst); }
	    else { return; }
	}

	return;
    }

    sub stepMinor {
	my $rst = shift || return;
	$rst =~ /$regex_str/i;
	my $a = $3;
	return $1.$2.++$a;
    }

    sub stepMajor {
	my $rst = shift || return;
	$rst =~ /$regex_str/i;
	return $1.($2+1).$3;
    }

    sub stepEp {
	my $rst = shift || return;
	$rst =~ /$regex_str/i;
	return unless $4;
	my $a = substr($4,1);
	return $1.$2.$3.'/'.++$a;
    }

    sub regDebug {
	my $rst = shift || return;
	$rst =~ /$regex_str/i;
	return($1,$2,$3,$4);
    }
    
    sub checkRst {
	my $rst = shift;
	return 1 if ($rst =~ /$regex_str/i);
	return;
    }
}
1;
