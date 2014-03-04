#!/usr/bin/perl

use warnings;
use strict;

use Text::CSV_PP;
use Data::Dumper qw(Dumper);

my $fn = 'test.csv';
open my $IF, "<", $fn or die "Could not open input file: $!";

my $csv = Text::CSV_PP->new({
  allow_whitespace    => 1,
  allow_loose_escapes => 1,
}) or die "Cannot use CSV: ".Text::CSV->error_diag();

$csv->column_names( $csv->getline($IF) );

my @lines;
while ( my $line = $csv->getline_hr($IF) ) {
    push @lines, +{ %{$line} };
    # $data->{ $line->{'CUSTOMER CODE'} } = $line;
}

print Dumper([\@lines]);
