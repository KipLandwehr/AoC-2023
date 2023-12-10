#!/usr/bin/perl
use warnings;
use strict;

my $debug = 0;
my $total = 0;

#	LLR
#	
#	AAA = (BBB, BBB)
#	BBB = (AAA, ZZZ)
#	ZZZ = (ZZZ, ZZZ)

$/ = "\n\n";

$_ = <>;
chomp;
my @instructions = split ( // );
foreach my $index ( 0..(@instructions-1) ) {
	if ( $instructions[$index] eq 'L' ) { $instructions[$index] = 0; }
	else { $instructions[$index] = 1; }
}

$/ = "\n";

my %nodes;
while (<>) {
	my ($node, $lNeigh, $rNeigh) = /[A-Z]{3}/g;
	$nodes{$node} = [$lNeigh, $rNeigh];
}

my $node = "AAA";

until ( $node eq "ZZZ" ) {
	my $instIndex = $total % scalar (@instructions);
	my $inst = $instructions[$instIndex];

	$node = $nodes{$node}[$inst];
	$total++;
}

# Print solution
print "Solution: $total\n";
