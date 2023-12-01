#!/usr/bin/perl
use warnings;
use strict;

my $debug = 0;

my $total = 0;

while (<>) {
	chomp;
	if ( $_ =~ /(\D*)?(\d)(.*)?(\d)(\D*)?/ ) {
		my $val = (10*$2 + $4);
		print "Value: $val\n" if ($debug > 0);;
		$total += $val;
	}
	elsif ( $_ =~ /(\D*)?(\d)(\D*)?/ ) {
		my $val = (10*$2 + $2);
		print "Value: $val\n" if ($debug > 0);
		$total += $val;
	}
	else {
		print "No match for line '$_'\n";
	}

}

# Print solution
print "Solution: $total\n";
