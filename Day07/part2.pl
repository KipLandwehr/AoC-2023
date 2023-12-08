#!/usr/bin/perl
use warnings;
use strict;

my $debug = 0;
my $total = 0;

#	32T3K 765
#	T55J5 684
#	KK677 28
#	KTJJT 220
#	QQQJA 483

my %letterValues = (
	A => 14,
	K => 13,
	Q => 12,
	J => 0,		# Joker. Lowest face value card
	T => 10,
);

my @hands;

while (<>) {
	chomp;
	my ($hand, $bid) = split ( /\s+/ );
	my @cards = split ( //, $hand );
	foreach my $index ( 0..(@cards-1) ) {
		if ( $cards[$index] =~ /[AKQJT]/ ) {
			$cards[$index] = $letterValues{$cards[$index]};
		}
	}

	if ( $debug > 4 ) {
		print "Line $.: [ ";
		foreach my $card ( @cards ) {
			print "$card ";
		}
		print "], $bid\n";
	}

	if ( $debug > 4 ) {
		my $type = getType(\@cards);
		print "Line $.: Type = $type\n\n";
		push ( @hands, [\@cards, $type, $bid] );
	}
	else {
		push ( @hands, [\@cards, getType(\@cards), $bid] );
	}
}

@hands = sort handSort @hands;

if ( $debug > 0 ) {
	print "Sorted Hands:\n";
	foreach my $hIndex ( 0..(@hands-1) ) {
		my @cards = @{$hands[$hIndex][0]};
		print "[ ";
		foreach my $card ( @cards ) {
			print "$card ";
		}
		print "], $hands[$hIndex][1], $hands[$hIndex][2]\n";
	}
}

foreach my $index ( 0..(@hands-1) ) {
	my $bid = $hands[$index][2];
	$total += $bid * ($index+1);
}

# Print solution
print "Solution: $total\n";

sub handSort {
	# $a and $b will be array refs containing (hand, handType, bid)
	my @h1 = @{$a};
	my @h2 = @{$b};

	my $h1Type = $h1[1];
	my $h2Type = $h2[1];

	my $compVal = $h1Type <=> $h2Type;

	if ( $compVal == 0 ) {
		# Check hand contents
		my @h1Cards = @{$h1[0]};
		my @h2Cards = @{$h2[0]};

		for my $index ( 0..(@h1Cards-1) ) {
			my $retVal = $h1Cards[$index] <=> $h2Cards[$index];
			next if ( $retVal == 0 );
			return $retVal;
		}
	}
	return $compVal;
}

sub getType {
	#	6 - Five of a kind: AAAAA
	#	5 - Four of a kind: AA8AA
	#	4 - Full house: 23332
	#	3 - Three of a kind: TTT98
	#	2 - Two pair: 23432
	#	1 - One pair: A23A4
	#	0 - High card: 23456

	print "Executing getType\n" if ( $debug > 5 );

	my $aRef = shift;
	my @cards = @{$aRef};

	if ( $debug > 6 ) {
		print "getType: Card values - [ ";
		foreach my $card (@cards) { print "$card "; }
		print "]\n";
	}

	my %counts;

	# count number of each card
	foreach my $card (@cards) { ++$counts{$card};}

	# sort puts higher values at higher indicies, so reverse sort
	my @sortedCount = reverse sort ( values %counts );

	my $firstCount = shift @sortedCount;
	
	# Even 5 Jokers is a 5 of a kind
	return 6 if ( $firstCount == 5 );

	if ( defined $counts{0} ) {
		my $jokerCount = $counts{0};

		# 1 any + 4 J make 5 of a kind
		return 6 if ($jokerCount == 4);
		# 5 unique cards, one of which is a J, makes one pair
		return 1 if ($firstCount == 1);

		my $secondCount = shift @sortedCount;

		if ( $jokerCount == 3 ) {
			# 3 wild + 2 same = 5 same
			return 6 if ( $secondCount == 2 );
			# 3 wild + 1 a + 1 b = 4 same
			return 5;
		}
		if ( $jokerCount == 2 ) {
			return 6 if ( $firstCount == 3 );

			# Assume the 2 in firstCount is the count of Jokers
			return 5 if ( $secondCount == 2 );
			return 3;
		}
		if ( $jokerCount == 1 ) {
			return 6 if ( $firstCount == 4 );
			return 5 if ( $firstCount == 3 );
			return 4 if ( $firstCount == 2 and $secondCount == 2 );
			return 3 if ( $firstCount == 2 and $secondCount == 1 );
		}
	}
	else {		
		if ( $debug > 6 ) {
			print "getType: sortedCount = [ ";
			foreach my $count ( @sortedCount ) { print "$count "; }
			print "]\n";
		}

		return 5 if ( $firstCount == 4 );
		return 0 if ( $firstCount == 1 );

		my $secondCount = shift @sortedCount;

		return 4 if ( $firstCount == 3 and $secondCount == 2 );
		return 3 if ( $firstCount == 3 and $secondCount == 1 );
		return 2 if ( $firstCount == 2 and $secondCount == 2 );
		return 1 if ( $firstCount == 2 and $secondCount == 1 );
	}
}