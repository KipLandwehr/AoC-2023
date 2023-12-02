#!/usr/bin/perl
use warnings;
use strict;

my $debug = 0;

my $total = 0;

while (<>) {
	chomp;
	my $gameID = 0;

	if ( $_ =~ /^Game (\d*): (.*)$/ ) {
		$gameID = $1;
		my @sets = split(/; /, $2);
		
		my %maximum = (
			red => 0, green => 0, blue => 0
		);

		foreach ( @sets ) {
			my @colors = split(/, /);

			foreach ( @colors ) {
				my ($num, $color) = split(/ /);
				$maximum{$color} = $num if ($num > $maximum{$color});
			}
		}
		my $power = 1;
		$power *= $_ foreach values %maximum;
		$total += $power;
	}
	else {
		print "Unmatched line in input: '$_'\n";
	}

}

# Print solution
print "Solution: $total\n";
