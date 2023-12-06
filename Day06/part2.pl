#!/usr/bin/perl
use POSIX 'floor';
use warnings;
use strict;

my $debug = 0;
my $total = 1;

# I'm lazy and just hardcoding my input for part 2 ...
my $time = 60947882;
my $dist = 475213810151650;

# Test input
#my $time = 71530;
#my $dist = 940200;

my $midTime = floor($time/2);
my $firstWin = 0;

# Start at 1, because 0*<anything> is 0, and not a winnable dist in any race
foreach my $num ( 1..$midTime ) {
	if ( $dist < ($num*($time-$num)) ) {
		$firstWin = $num;
		last;
	}
}

$total = 2 * (($midTime - $firstWin) + 1);
$total-- if ( $time % 2 == 0 );

# Print solution
print "Solution: $total\n";
