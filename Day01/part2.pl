#!/usr/bin/perl
use warnings;
use strict;

my $debug = 0;

my $total = 0;

while (<>) {
	chomp;
	if ( $_ =~ /(\D*)?(\d)(.*)?(\d)(\D*)?/ ) {
		my ($cOne, $dOne, $dTwo, $cTwo) = ($1, $2, $4, $5);

		my $digitOne = 0;
		my $digitTwo = 0;

		# Check first set of chars for number-words

		# Regex explanation:
		# capture any string that doesn't match a number-word (ex "one")
		# (?:(?!(one|two|three|four|five|six|seven|eight|nine)).)*
		# then capture the first number-word
		# (one|two|three|four|five|six|seven|eight|nine)
		# then match everything else but don't catpure it
		# .*
		if ($cOne =~ /^(?:(?!(one|two|three|four|five|six|seven|eight|nine)).)*(one|two|three|four|five|six|seven|eight|nine).*$/) {
			if ($2 eq "one")		{ $digitOne = 1; }
			elsif ($2 eq "two")		{ $digitOne = 2; }
			elsif ($2 eq "three")	{ $digitOne = 3; }
			elsif ($2 eq "four")	{ $digitOne = 4; }
			elsif ($2 eq "five")	{ $digitOne = 5; }
			elsif ($2 eq "six")		{ $digitOne = 6; }
			elsif ($2 eq "seven")	{ $digitOne = 7; }
			elsif ($2 eq "eight")	{ $digitOne = 8; }
			elsif ($2 eq "nine")	{ $digitOne = 9; }
			else					{ print "How? (1)"; }
		}
		else { $digitOne = $dOne; }

		# Check second set of chars for number-words

		# Regex explanation:
		# Regex is greedy, so will match as much as possible in the first .* before matching a single number-word
		# So, this will match as many characters as it can before it must match a number-word,
		# including other number-words
		# This should take a string like "nineeightseven" and the first .* should eat "nineeight"
		# then, the capture (parenthetical) is forced to match "seven"
		# The final .* matches and throws away any trailing characters,
		# which necessarily do not match a number-word
		if ($cTwo =~ /^.*(one|two|three|four|five|six|seven|eight|nine).*$/) {
			if ($1 eq "one")		{ $digitTwo = 1; }
			elsif ($1 eq "two")		{ $digitTwo = 2; }
			elsif ($1 eq "three")	{ $digitTwo = 3; }
			elsif ($1 eq "four")	{ $digitTwo = 4; }
			elsif ($1 eq "five")	{ $digitTwo = 5; }
			elsif ($1 eq "six")		{ $digitTwo = 6; }
			elsif ($1 eq "seven")	{ $digitTwo = 7; }
			elsif ($1 eq "eight")	{ $digitTwo = 8; }
			elsif ($1 eq "nine")	{ $digitTwo = 9; }
			else					{ print "How? (2)"; }
		}
		else { $digitTwo = $dTwo; }

		my $val = (10*$digitOne + $digitTwo);
		print "Value: $val\n" if ($debug > 0);;
		$total += $val;
	}
	elsif ( $_ =~ /(\D*)?(\d)(\D*)?/ ) {
		my ($cOne, $digit, $cTwo) = ($1, $2, $3);

		my $digitOne = 0;
		my $digitTwo = 0;

		# Check first set of chars for number-words

		# Same regex as cOne above
		if ($cOne =~ /^(?:(?!(one|two|three|four|five|six|seven|eight|nine)).)*(one|two|three|four|five|six|seven|eight|nine).*$/) {
			if ($2 eq "one")		{ $digitOne = 1; }
			elsif ($2 eq "two")		{ $digitOne = 2; }
			elsif ($2 eq "three")	{ $digitOne = 3; }
			elsif ($2 eq "four")	{ $digitOne = 4; }
			elsif ($2 eq "five")	{ $digitOne = 5; }
			elsif ($2 eq "six")		{ $digitOne = 6; }
			elsif ($2 eq "seven")	{ $digitOne = 7; }
			elsif ($2 eq "eight")	{ $digitOne = 8; }
			elsif ($2 eq "nine")	{ $digitOne = 9; }
			else					{ print "How? (3)"; }
		}
		else { $digitOne = $digit; }

		# Check second set of chars for number-words

		# Same regex as cTwo above
		if ($cTwo =~ /^.*(one|two|three|four|five|six|seven|eight|nine).*$/) {
			if ($1 eq "one")		{ $digitTwo = 1; }
			elsif ($1 eq "two")		{ $digitTwo = 2; }
			elsif ($1 eq "three")	{ $digitTwo = 3; }
			elsif ($1 eq "four")	{ $digitTwo = 4; }
			elsif ($1 eq "five")	{ $digitTwo = 5; }
			elsif ($1 eq "six")		{ $digitTwo = 6; }
			elsif ($1 eq "seven")	{ $digitTwo = 7; }
			elsif ($1 eq "eight")	{ $digitTwo = 8; }
			elsif ($1 eq "nine")	{ $digitTwo = 9; }
			else					{ print "How? (4)"; }
		}
		else { $digitTwo = $digit; }

		my $val = (10*$digitOne + $digitTwo);
		print "Value: $val\n" if ($debug > 0);
		$total += $val;
	}
	else {
		print "No match for line '$_'\n";
	}

}

# Print solution
print "Solution: $total\n";
