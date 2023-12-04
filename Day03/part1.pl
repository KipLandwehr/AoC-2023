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
	print " Line index $line\n" if $debug > 1;

	my $FCD = 0;	# Finding Contiguous Digits? (initialize to false)
	my $startIndex;
	my $endIndex;

	my $value = 0;

	foreach my $char ( 0..(@{$input[$line]} - 1) ) {
		print "$input[$line][$char]" if $debug > 0 ;

		# if char is a digit
		if ( $input[$line][$char] =~ /\d/ ) {
			print " - Detected char as digit\n" if $debug > 1;
			# if this is the left-most digit of the number
			unless ( $FCD ) {
				print "  - Detected digit as first in number\n" if $debug > 1;
				$startIndex = $char;
				$FCD = 1;
			}
			$value = (10 * $value) + $input[$line][$char];
			$endIndex = $char;
			# If this is the last character of the line, we need to process the number
			if ( $char == (@{$input[$line]} - 1) ) {
				print "  - Detected end of number\n" if $debug > 2;
				if ( isPartNum($line, $startIndex, $endIndex) ) {
					print "   - Detected number as a part-number\n" if $debug > 3;
					print "   - Increased total by $value\n" if $debug > 3;
					$total += $value 
				}
			}
		}
		else {
			print " - Detected char as non-digit\n" if $debug > 1;
			# if we were still Finding Contiguous Digits, then we just detected the end ...
			# and that means we actually need to do stuff
			if ( $FCD ) {
				print "  - Detected end of number\n" if $debug > 2;
				if ( isPartNum($line, $startIndex, $endIndex) ) {
					print "   - Detected number as a part-number\n" if $debug > 3;
					print "   - Increased total by $value\n" if $debug > 3;
					$total += $value 
				}
				#Indicate that we're not currently finding contiguous digits anymore
				$FCD = 0;
				# Set start and end Index of current number to Undefined, because there is no current number now
				undef $startIndex;
				undef $endIndex;
				# Reset value back to 0, so it's ready for the next number
				$value = 0;
			}
			# otherwise we're just scrolling through and just keep moving
			# (i.e. do nothing and go to the next character in the line)
		}

	}
	print "\n" if $debug > 0;
}

# Print solution
print "Solution: $total\n";

# This function checks if a number - defined by its Input Line num, Start Index, and End Index - is a part number
# This function assumes that the input is rectangular (all lines are the same width)
sub isPartNum {
	print "    - Entered isPartNum\n" if $debug > 5;

	my $numLine = shift;
	my $numStart = shift;
	my $numEnd = shift;

	my $CSL = $numLine;		# Check Start Line = line of number to be checked
	my $CEL = $numLine;		# Check End Line = line of number to be checked
	my $CSI = $numStart;	# Check Start Index = number starting index
	my $CEI = $numEnd;		# Check End Index = number ending index

	if ( $CSL > 0 ) { --$CSL; }
	if ( $CSI > 0 ) { --$CSI; }
	# Only increment end line if numLine is two less than the total number of lines
	# Ex. If 100 lines of input, then numLine should be (index number) 98 or less to increment CEL
	if ( $CEL < (@input - 2) ) { ++$CEL; }
	if ( $CEI < (@{$input[$numLine]} -2) ) { ++$CEI; }

	foreach my $cline ( $CSL..$CEL ) {
		foreach my $cindex ( $CSI..$CEI ) {
			# Return true the first time we find a special character in the check box
			if ( $input[$cline][$cindex] =~ /[^\d\.]/ ) {
				print "    - isPartNum evals to True\n" if $debug > 5;
				return 1;
			}
		}
	}
	# We got through the entire check box and didn't find a special character, so return false
	print "    - isPartNum evals to False\n" if $debug > 5;
	return 0;
}
