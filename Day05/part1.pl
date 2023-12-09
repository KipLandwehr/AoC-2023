#!/usr/bin/perl
use warnings;
use strict;
use List::Util 'min';

my $debug = 0;

my $total = 0;

#	Input Format
#	dstStart srcStart rangeLen
#	soilStart seedStart rangeLen	(for seed-to-soil map)

# Set input record separator to two newline characters
$/ = "\n\n";

# Get first line of input
$_ = <>;
chomp;
my @seeds = /(\d+)/g;

if ( $debug > 0 ) {
	foreach my $seed ( @seeds ) { print "$seed "; }
	print "\n";
}

my %seedValue;
foreach my $seed ( @seeds ) { $seedValue{$seed} = $seed; }

while (<>) {
	chomp;
	my @lineStrings = split ( "\n" );
	my @lines;

	# The first line is always the header, which I don't care about, so start on the next line (index 1)
	foreach my $linenum ( 1 .. (@lineStrings-1) ) {
		push(@lines, [ split(/\s+/, $lineStrings[$linenum]) ]);
	}

	SEED: foreach my $seed ( @seeds ) {
		my $sValue = $seedValue{$seed};

		foreach my $line ( 0..@lines-1 ) {
			my $dstRangeStart = $lines[$line][0];
			my $srcRangeStart = $lines[$line][1];
			my $srcRangeEnd = $lines[$line][1] + $lines[$line][2] - 1;

			if ( $sValue >= $srcRangeStart and $sValue <= $srcRangeEnd ) {
				print "Value: $sValue. Src: $srcRangeStart - $srcRangeEnd. Dst: $dstRangeStart\n" if $debug > 0;
				my $delta = $sValue - $srcRangeStart;

				my $newValue = $dstRangeStart + $delta;
				print "Value: $sValue. New Value = $newValue\n" if $debug > 0;
				
				$seedValue{$seed} = $dstRangeStart + $delta;
				next SEED;
			}
		}
	}
}

$total = min values %seedValue;

# Print solution
print "Solution: $total\n";
