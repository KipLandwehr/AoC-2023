#!/usr/bin/perl
use warnings;
use strict;
use Cwd;

my $cwd = cwd();
#require "$cwd/testFunctions.pl";
require "$cwd/realFunctions.pl";


my $debug = 0;
my $total = 0;

# Throw all of the function definitions away, because we pre-processed those
while (<>) {
	chomp;
	last if $_ =~ /^$/;
}

while (<>) {
	chomp;
	my @xmas = /(\d+)/g;

	if ( in(\@xmas) eq 'A' ) {
		print "Accepted gear with x=", $xmas[0], "\n" if $debug > 0;
		foreach my $val ( @xmas ) {
			$total += $val;
		}
	}
}

# Print solution
print "Solution: $total\n";
