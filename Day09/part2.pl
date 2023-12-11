#!/usr/bin/perl
use warnings;
use strict;

my $debug = 0;
my $total = 0;

#	0 3 6 9 12 15
#	1 3 6 10 15 21
#	10 13 16 21 30 45

while (<>) {
	chomp;
	my @values = split (' ');
	print "Input line $. -\n" if ($debug > 0);
	$total += getPrediction(@values);
}

# Print solution
print "Solution: $total\n";

sub getPrediction {
	my $hIndex = (scalar(@_) - 1);

	# Assume all zeros (true)
	my $allZero = 1;

	# Set to false, unless index 0 is 0.
	$allZero = 0 unless ( $_[0] == 0 );

	my @array;
	foreach my $index ( 1..$hIndex ) {
		my $val = $_[$index] - $_[$index-1];
		push (@array, $val);

		# Set to false, unless current index is 0
		$allZero = 0 unless ( $_[$index] == 0 );
	}
	return 0 if ( $allZero );
	my $retVal = $_[0] - getPrediction(@array);
	print "Prediction value: $retVal\n" if ($debug > 1);
	return $retVal;
}