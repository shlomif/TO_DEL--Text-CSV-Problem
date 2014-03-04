#!/usr/bin/perl

use warnings;
use strict;

use Test::More tests => 1;

use Text::CSV_PP;
use Data::Dumper qw(Dumper);

{
    my $csv_text = <<'EOF';
"DIVISION CODE", "DIVISION DESCRIPTION", "CUSTOMER CODE", "CUSTOMER NAME", "SHORT NAME", "ADDRESS LINE 1", "ADDRESS LINE 2", "ADDRESS LINE 3", "TOWN", "COUNTY", "POST CODE", "COUNTRY", "GRID REF", "TELEPHONE", "AGENT CODE", "YEAR TO DATE SALES"
"1", "UK", "AA147", "Aardvark Music", "AARDVA", "Compton House", "9 Totnes Road", "", "PAIGNTON", "Devon", "TQ4 5JX", "", "", "01803 664481", "", 0.00
"2", "EC", "CA175", "La Manticora, S.L. (Camden)", "LA MAN", "C/ Pallers 85-91 2n4a", "", "", "08018 BARCELONA", "", "", "Spain", "", "0034 93 551 0768", "", 0.00
EOF

    open my $IF, "<", \$csv_text;

    my $csv = Text::CSV_PP->new({
            allow_whitespace    => 1,
            allow_loose_escapes => 1,
        }) or die "Cannot use CSV: ".Text::CSV->error_diag();

    $csv->column_names( $csv->getline($IF) );

    {
        my $first_line = $csv->getline_hr($IF);

        # TEST
        is ($first_line->{'POST CODE'}, 'TQ4 5JX',
            "First line POST CODE"
        );

        # TEST
        is ($first_line->{'COUNTRY'}, '',
            "First line COUNTRY",
        );

        # TEST
        is ($first_line->{'GRID REF'}, '',
            "First line GRID REF",
        );

        # TEST
        is ($first_line->{'TELEPHONE'}, '01803 664481',
            "First line TELEPHONE",
        );
    }
    close($IF);
}
