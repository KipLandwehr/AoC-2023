#!/usr/bin/perl
use POSIX 'floor';
use warnings;
use strict;

my $debug = 0;
my $total = 1;

#	Time:      7  15   30
#	Distance:  9  40  200

# Get first line of input
$_ = <>;
chomp;
my @times = /(\d+)/g;

# Get second line of input
$_ = <>;
my @dists = /(\d+)/g;

foreach my $input ( 0..((scalar @times)-1) ) {
	my $time = $times[$input];
	my $dist = $dists[$input];

	my $winners = 0;

	my $midTime = floor($time/2);
	# Start at 1, because 0*<anything> is 0, and not a winnable dist in any race
	# End at midTime, because our combinations are mirrored over the centerline.
	# So, add two for each winner ...
	foreach my $num ( 1..$midTime ) {
		$winners += 2 if ( $dist < ($num*($time-$num)) );
	}
	# And if time was even, subtract one, because there's only one combination for the center number
	# Ex: Time = 30. 15 * 15 is only one combination, so only count it once.
	$winners-- if ( $time % 2 == 0 );

	print "Round $input winners: $winners\n" if ($debug > 0);

	$total *= $winners;
}

# Print solution
print "Solution: $total\n";
