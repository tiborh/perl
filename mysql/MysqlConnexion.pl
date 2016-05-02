#!/usr/bin/env perl

use warnings;
use v5.14; 			# implies strict
use Carp;
use utf8;
use autodie;
#the following two needs installation:
#use Modern::Perl;
#use Test::More;

binmode(STDOUT, ":utf8");

use MysqlConnexion;

my $test_conn = new MysqlConnexion();

$test_conn->connect_db();

my $data = $test_conn->db_get("select username, emailaddr from subscribers");
say "Data received: $_ => ",@{$data->{$_}} foreach (keys %$data);

my $dbconn = new MysqlConnexion(
    _dbuser => 'tibor',
    _dbuserpass => '',
    );

$dbconn->connect_db();

# add data
my $query_text = 'insert ignore into subscribers (username, emailaddr) values("bim", "bim@gmail.com")'; 
$dbconn->db_set($query_text);

# query data
$data = $dbconn->db_get("select username, emailaddr from subscribers");
say "Data received: $_ => ",@{$data->{$_}} foreach (keys %$data);

# remove added data
$query_text = "delete from subscribers where username='bim'";
$dbconn->db_set($query_text);

# note: fields to query are probably best in an array to guarantee convenient printing of the results.
