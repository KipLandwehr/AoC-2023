#!/usr/bin/perl
use List::Util 'sum';
use warnings;
use strict;

my $debug = 0;

my $total = 0;

#	Card 1: 41 48 83 86 17 | 83 86  6 31 17  9 48 53
#	Card 2: 13 32 20 16 61 | 61 30 68 82 17 32 24 19
#	Card 3:  1 21 53 59 44 | 69 82 63 72 16 21 14  1
#	Card 4: 41 92 73 84 69 | 59 84 76 51 58  5 54 83
#	Card 5: 87 83 26 28 32 | 88 30 70 12 93 22 82 36
#	Card 6: 31 18 13 56 72 | 74 77 10 23 35 67 36 11

#	Card   9: 26 44 60 20 11 15 16 95 18 47 | 71 56 10 57 65 90 32 30 13 42 19 55 29 12 89 91  2 67 79 58 99  4 81 41 69
#	Card  10: 68 65 79  3 44 55 12 71 47 84 | 47 65 93  4 71 23 17 30 59 85  3 28 95 36 88 12  7 97 68 62 84 21 79 61 44

my %cardCounts;

while (<>) {
	chomp;
	my ($cardID, $winNumStr, $myNumStr) = m/^Card[\s]+([\d]+):[\s]([\d\s]*)[\s]\|[\s]+([\d\s]*)$/;
	++$cardCounts{$cardID};
	my @winNums = split ( /\s+/, $winNumStr );
	my @myNums = split ( /\s+/, $myNumStr );

	my $matches = 0;

	foreach my $num ( @myNums ) {
		$matches++ if ( grep(/^$num$/, @winNums) );
	}

	if ( $matches > 0 ) {
		foreach my $i ( 1..$matches ) {
			$cardCounts{($cardID+$i)} += $cardCounts{$cardID};
		}
	}
}

$total = sum values %cardCounts;

# Print solution
print "Solution: $total\n";
