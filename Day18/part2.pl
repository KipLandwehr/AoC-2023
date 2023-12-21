#!/usr/bin/perl
use warnings;
use strict;

my $debug = 0;
my $total = 0;

#	R 6 (#70c710)
#	D 5 (#0dc571)
#	L 2 (#5713f0)
#	D 2 (#d2c081)
#	R 2 (#59c680)
#	D 2 (#411b91)
#	L 5 (#8ceee2)
#	U 2 (#caa173)
#	L 1 (#1b58a2)
#	U 2 (#caa171)
#	R 2 (#7807d2)
#	U 3 (#a77fa3)
#	L 2 (#015232)
#	U 2 (#7a21e3)

sub determinant;

my @dirlookup = ( 'R', 'D', 'L', 'U' );

# Assume that we start at (0, 0)
my ($x, $y) = (0, 0);
my $perimeter = 0;

# Use the shoelace formula to calculate the area of the shape defined by the input
while (<>) {
	chomp;
	my ($hexnum, $dirnum) = $_ =~ /^[UDLR]\s[\d]+\s\(#([a-z\d]{5})([0-3])\)$/;
	
	my $dir = $dirlookup[$dirnum];
	my $num = hex("0x$hexnum");

	$perimeter += $num;

	print "$dir, $num\n" if $debug > 0;

	if ( $dir eq 'U' ) {
		print "$x, $y, $x, ", $y-$num, "\n" if $debug > 1;
		$total += determinant($x, $y, $x, $y-$num);
		$y -= $num;
	}
	if ( $dir eq 'D' ) {
		print "$x, $y, $x, ", $y+$num, "\n" if $debug > 1;
		$total += determinant($x, $y, $x, $y+$num);
		$y += $num;
	}
	if ( $dir eq 'L' ) {
		print "$x, $y, ", $x-$num, ", $y\n" if $debug > 1;
		$total += determinant($x, $y, $x-$num, $y);
		$x -= $num;
	}
	if ( $dir eq 'R' ) {
		print "$x, $y, ", $x+$num, ", $y\n" if $debug > 1;
		$total += determinant($x, $y, $x+$num, $y);
		$x += $num;
	}
	print "\n" if $debug > 0;
}

$total = abs($total) / 2;
$total += ($perimeter / 2) + 1;

# Print solution
print "Solution: $total\n";


sub determinant {
	my $x1 = shift;
	my $y1 = shift;
	my $x2 = shift;
	my $y2 = shift;

	my $val = ($x1*$y2) - ($x2*$y1);
	print "Determinant: $val\n" if $debug > 2; 
	return ( ($x1*$y2) - ($x2*$y1) );
}