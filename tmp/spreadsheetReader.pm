package spreadsheetReader v0.0.1{
    use warnings;
    use v5.14; 			# implies strict
    use Carp;
    use utf8;
    use autodie;

    binmode(STDOUT, ":utf8");

    use Spreadsheet::Read;

    sub getStructure {
	my $fn = shift || return;
	my $book = getData($fn);
	croak "Empty book. Exiting..." unless $book;
	my $dataTables = &makeTables($book);
	croak "Empty data tables. Exiting..." unless $dataTables;
	my $dataStructures = &makeStructures($dataTables);
	croak "Empty data structure. Exiting..." unless $dataStructures;

	return $dataStructures;
    }

    sub getData() {
	my $fn = shift || return;
	my $book = ReadData($fn);
	return $book;
    }

    sub explorer {
	my $book = shift || return;
	my $nu_of_sheets = $book->[0]->{"sheets"};
	say "The input file argument: ",$ARGV[0];
	say "Number of sheets: ",$nu_of_sheets;

	for (my $i = 1; $i <= $nu_of_sheets; ++$i) {
	    &book_examine($book,$i);
	    &print_cells($book,$i);
	}
	return 1;
    }

    sub makeStructures {
	my $tableStructure = shift || return;
	my $dataStructures;

	foreach my $sheet (keys %$tableStructure) {
	    $dataStructures->{$sheet} = &trCommon::makeDataStruct($tableStructure->{$sheet},1);
	}

	return $dataStructures;
    }

    sub printDataStructures {
	my $dataStructure = shift || return;
	foreach my $sheet (keys %$dataStructure) {
	    say "Sheet $sheet";
	    &trCommon::printDataStruct($dataStructure->{$sheet});
	}

	return 1;
    }

    sub printDataTables {
	my $tableStructure = shift || return;
	foreach my $sheet (keys %$tableStructure) {
	    say "Sheet: $sheet";
	    &trCommon::printDataTable($tableStructure->{$sheet});
	}

	return 1;
    }

    sub makeTables {
	my $book = shift || return;
	my $nuOfSheets = $book->[0]->{"sheets"} || return;
	my $dataStruct;

	for (my $i = 1; $i <= $nuOfSheets; ++$i) {
	    $dataStruct->{$book->[$i]->{"label"}} = &makeTable($book,$i);
	}

	return $dataStruct;
    }

    sub makeTable {
	my $book = shift || return;
	my $sheet = shift || return;
	my $dataTable;

	for my $row (1..$book->[$sheet]->{"maxrow"}) {
	    for my $col (1..$book->[$sheet]->{"maxcol"}) {
		my $cellValue = $book->[$sheet]->{"cell"}->[$col]->[$row];
		$dataTable->[$row-1]->[$col-1] = defined($cellValue) ? $cellValue : "null";
	    }
	}

	return $dataTable;
    }

    sub book_examine {
	my $book = shift || return;
	my $sheet = shift || return;

	say "Sheet $sheet";
	say "\tlabel: ",$book->[$sheet]->{"label"};
	say "\tmaxrow: ",$book->[$sheet]->{"maxrow"};
	say "\tmaxcol: ",$book->[$sheet]->{"maxcol"};
	say "\tattr: ",@{$book->[$sheet]->{"attr"}};
	say "\tmerged: ",@{$book->[$sheet]->{"merged"}};
	say "the sheet has ",$#{$book->[$sheet]->{"cell"}}," columns.";

	return 1;
    }

    sub print_cells {
	my $book = shift || return;
	my $sheet = shift || return;

	for my $row (1..$book->[$sheet]->{"maxrow"}) {
	    for my $col (1..$book->[$sheet]->{"maxcol"}) {
		my $value = $book->[$sheet]->{"cell"}->[$col]->[$row];
		print defined($value) ? $value : "undef";
		print "\t";
	    }
	    say "";
	}

	return 1;
    }
}
1;
