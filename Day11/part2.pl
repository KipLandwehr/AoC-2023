#!/usr/bin/perl
use warnings;
use strict;

my $debug = 0;
my $total = 0;

my $extraSpaceConst = 1000000 - 1;
my $emptyRows = 0;
my $emptyCols = 0;

my @input;
my @galaxies;

while (<>) {
	chomp;
	my @line = split(//);
	push ( @input, \@line );

	print "Input Line: $.\n" if ( $debug > 1 );

	if ( grep(/^#$/, @line) ) {
		print "Galaxy detected\n" if ( $debug > 1 );
		foreach my $index ( 0..(@line-1) ) {
			if ( $line[$index] eq '#' ) {
				my $row = ($. - 1) + ($emptyRows * $extraSpaceConst);
				push ( @galaxies, [ $row, $index ] );
			}
		}
	}
	else {
		$emptyRows++;
	}
}

my @colOffset;

# Find column value offsets
# $input[$row][$col]
COL: foreach my $col ( 0..(@{$input[0]}-1) ) {
	foreach my $row ( 0..(@input-1) ) {
		if ( $input[$row][$col] eq '#' ) {
			push ( @colOffset, ($emptyCols * $extraSpaceConst) );
			next COL;
		}
	}
	# Didn't find a # in the column, so...
	push ( @colOffset, ($emptyCols * $extraSpaceConst) );
	$emptyCols++;
}

# Update column values for each galaxy
foreach my $aRef ( @galaxies ) {
	$$aRef[1] += $colOffset[$$aRef[1]];
}

if ( $debug > 0 ) {
	foreach my $aRef ( @galaxies ) {
		print "[ $$aRef[0], $$aRef[1] ]\n";
	}
}

# Calulate the Manhattan Distance for each pair and add to total
foreach my $i ( 0..(@galaxies-2) ) {
	foreach my $j ( ($i+1)..(@galaxies-1) ) {
		my $rowDist = abs($galaxies[$i][0] - $galaxies[$j][0]);
		my $colDist = abs($galaxies[$i][1] - $galaxies[$j][1]);
		$total += ( $rowDist ) + ( $colDist );
	}
}

# Find the length of the shortest path between every pair of galaxies.
# What is the sum of these lengths?

# Print solution
print "Solution: $total\n";
