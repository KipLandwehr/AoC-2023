#!/usr/bin/perl
use warnings;
use strict;

my $debug = 0;

my $total = 0;
my @input;

# read input into "2d array"
while (<>) {
	chomp;
	my @chars = split(//);
	push ( @input, \@chars );
}

foreach my $line ( 0..(@input - 1) ) {
	foreach my $char ( 0..(@{$input[$line]} - 1) ) {
		# if char is a *
		if ( $input[$line][$char] =~ /\*/ ) {
			print " - Detected ($line,$char) as potential gear\n" if $debug > 0;

			my $value = getGearRatio($line, $char);
			print " -- Gear Ratio is $value. (0 means not a gear)\n" if $debug > 1;

			$total += $value;
		}
	}
}

# Print solution
print "Solution: $total\n";

# This function checks if a number - defined by its Input Line num, Start Index, and End Index - is a part number
# This function assumes that the input is rectangular (all lines are the same width)
sub getGearRatio {
	print "    - Entered isGearRatio\n" if $debug > 2;

	my $gearLine = shift;
	my $gearIndex = shift;

	my @numbers;

	# My input does not have any * on the outer edge, so can start always check the immediate perimeter

	# For the line the * is on
	if ( $input[$gearLine][$gearIndex-1] =~ /\d/ ) {
		my $numEnd = $gearIndex - 1;
		my $numStart = $gearIndex - 1;
		my $number = 0;
		while ( $numStart > 0 and $input[$gearLine][$numStart-1] =~ /\d/ ) {
			--$numStart;
		}
		foreach my $digit ( $numStart..$numEnd ) {
			$number = 10*$number + $input[$gearLine][$digit];
		}
		push ( @numbers, $number );
	}
	if ( $input[$gearLine][$gearIndex+1] =~ /\d/ ) {
		my $numStart = $gearIndex + 1;
		my $numEnd = $gearIndex + 1;
		my $number = 0;
		while ( $numEnd < (@{$input[$gearLine]} - 1) and $input[$gearLine][$numEnd+1] =~ /\d/ ) {
			++$numEnd;
		}
		foreach my $digit ( $numStart..$numEnd ) {
			$number = 10*$number + $input[$gearLine][$digit];
		}
		push ( @numbers, $number );
	}
	
	# Check lines before and after *
	foreach my $line ( ($gearLine-1), ($gearLine+1) ) {
		# Check middle first, because if it's a digit, we only have one number touching on the line
		# If it's not, then we have 0, 1, or 2, but we know any we do have terminate on the corner adjacency
		if ( $input[$line][$gearIndex] =~ /\d/ ) {
			my $numStart = $gearIndex;
			my $numEnd = $gearIndex;
			my $number = 0;
			while ( $numStart > 0 and $input[$line][$numStart-1] =~ /\d/ ) {
				--$numStart;
			}
			while ( $numEnd < (@{$input[$line]} - 1) and $input[$line][$numEnd+1] =~ /\d/ ) {
				++$numEnd;
			}
			foreach my $digit ( $numStart..$numEnd ) {
				$number = 10*$number + $input[$line][$digit];
			}
			push ( @numbers, $number );
		}
		else {
			# Check left corner going left
			if ( $input[$line][$gearIndex-1] =~ /\d/ ) {
				my $numStart = $gearIndex-1;
				my $numEnd = $gearIndex-1;
				my $number = 0;
				while ( $numStart > 0 and $input[$line][$numStart-1] =~ /\d/ ) {
					--$numStart;
				}
				foreach my $digit ( $numStart..$numEnd ) {
					$number = 10*$number + $input[$line][$digit];
				}
				push ( @numbers, $number );
			}
			# Check right corner going right
			if ( $input[$line][$gearIndex+1] =~ /\d/ ) {
				my $numStart = $gearIndex+1;
				my $numEnd = $gearIndex+1;
				my $number = 0;
				while ( $numEnd < (@{$input[$line]} - 1) and $input[$line][$numEnd+1] =~ /\d/ ) {
					++$numEnd;
				}
				foreach my $digit ( $numStart..$numEnd ) {
					$number = 10*$number + $input[$line][$digit];
				}
				push ( @numbers, $number );
			}
		}
	}

	if ( @numbers == 2 ) {
		# * has exactly two adjacent numbers, so is in fact a gear
		my $ratio = $numbers[0] * $numbers[1];
		return $ratio;
	}
	else {
		# * is not actually a gear, so just return 0 to not change the total for answer
		return 0;
	}
}
