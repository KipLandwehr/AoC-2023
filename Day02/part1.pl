#!/usr/bin/perl
use warnings;
use strict;

my $debug = 0;

my $total = 0;


# 12 red cubes, 13 green cubes, and 14 blue cubes
my %maximum = (
	red => 12, green => 13, blue => 14
);

INPUT: while (<>) {
	chomp;
	my $gameID = 0;

	if ( $_ =~ /^Game (\d*): (.*)$/ ) {
		$gameID = $1;
		my @sets = split(/; /, $2);

		foreach ( @sets ) {
			my @colors = split(/, /);

			foreach ( @colors ) {
				my ($num, $color) = split(/ /);
				next INPUT if ($num > $maximum{$color});
			}
		}
		$total += $gameID;
	}
	else {
		print "Unmatched line in input: '$_'\n";
	}

}

# Print solution
print "Solution: $total\n";
