#!/usr/bin/perl
use warnings;
use strict;

my $debug = 0;
my $total = 0;

my %funcs;

while (<>) {
	chomp;
	last if $_ =~ /^$/;

	my ($funcName, $ruleStr) = $_ =~ /^([\w]+)\{(.*)\}$/;
	$funcs{$funcName} = [ split ',', $ruleStr ];
}

$total = getNumCom( "in", 1, 4000, 1, 4000, 1, 4000, 1, 4000 );

# Print solution
print "Solution: $total\n";


sub getNumCom {
	my $func = shift;

	my $minX = shift;
	my $maxX = shift;
	my $minM = shift;
	my $maxM = shift;
	my $minA = shift;
	my $maxA = shift;
	my $minS = shift;
	my $maxS = shift;

	my @rules = @{$funcs{$func}};

 	if ($debug > 0) {
		print "\n";
		print "Eval func $func\n";
		print "Rules: ";
		foreach my $rule ( @rules ) {
			print "$rule,";
		}
		print "\n";
		print "Vals - X: $minX, $maxX; M: $minM, $maxM; A: $minA, $maxA; S: $minS, $maxS\n";
	}

	my $retVal = 0;

	RULE: foreach my $rule ( @rules ) {
		# if the rule conditionally returns the result of a function or A or R
		if ( $rule =~ /^([xmas])([<>])([\d]+):([a-z]+|[AR])$/ ) {
			my $letter = $1;
			my $comp = $2;
			my $val = $3;
			my $ret = $4;

			if ( $comp eq '>' ) {
				if ( $letter eq 'x' ) {
					if ( $maxX > $val ) {
						if ( $minX > $val ) {
							# If the return is a function call
							if ( $ret =~ /[a-z]+/ ) {
								$retVal += getNumCom ($ret, $minX, $maxX, $minM, $maxM, $minA, $maxA, $minS, $maxS);
							}
							# otherwise, it's an A or R return
							else {
								if ( $ret eq 'A' ) {
									my $numX = ($maxX - $minX) + 1;
									my $numM = ($maxM - $minM) + 1;
									my $numA = ($maxA - $minA) + 1;
									my $numS = ($maxS - $minS) + 1;

									$retVal += $numX * $numM * $numA * $numS;
								}
								# This is a case where we've matched all parts (min > val), and we reject them all
								# Do not continue processing rules for these parts, and "return 0" for them
								else { last RULE; }
							}
						}
						else {
							# If the return is a function call
							if ( $ret =~ /[a-z]+/ ) {
								$retVal += getNumCom ($ret, $val+1, $maxX, $minM, $maxM, $minA, $maxA, $minS, $maxS);
							}
							# otherwise, it's an A or R return
							else {
								if ( $ret eq 'A' ) {
									my $numX = ($maxX - $val);
									my $numM = ($maxM - $minM) + 1;
									my $numA = ($maxA - $minA) + 1;
									my $numS = ($maxS - $minS) + 1;

									$retVal += $numX * $numM * $numA * $numS;
								}
							}
							# Move the max down for processing against remaining rules
							$maxX = $val;
						}
					}
				}
				if ( $letter eq 'm' ) {
					#	px{ ... , m>2090:A , ... }
					if ( $maxM > $val ) {
						if ( $minM > $val ) {
							# If the return is a function call
							if ( $ret =~ /[a-z]+/ ) {
								$retVal += getNumCom ($ret, $minX, $maxX, $minM, $maxM, $minA, $maxA, $minS, $maxS);
							}
							# otherwise, it's an A or R return
							else {
								if ( $ret eq 'A' ) {
									my $numX = ($maxX - $minX) + 1;
									my $numM = ($maxM - $minM) + 1;
									my $numA = ($maxA - $minA) + 1;
									my $numS = ($maxS - $minS) + 1;

									$retVal += $numX * $numM * $numA * $numS;
								}
								# This is a case where we've matched all parts (min > val), and we reject them all
								# Do not continue processing rules for these parts, and "return 0" for them
								else { last RULE; }
							}
						}
						else {
							# If the return is a function call
							if ( $ret =~ /[a-z]+/ ) {
								$retVal += getNumCom ($ret, $minX, $maxX, $val+1, $maxM, $minA, $maxA, $minS, $maxS);
							}
							# otherwise, it's an A or R return
							else {
								if ( $ret eq 'A' ) {
									my $numX = ($maxX - $minX) + 1;
									my $numM = ($maxM - $val);
									my $numA = ($maxA - $minA) + 1;
									my $numS = ($maxS - $minS) + 1;

									$retVal += $numX * $numM * $numA * $numS;
								}
							}
							# Move the max down for processing against remaining rules
							$maxM = $val;
						}
					}
				}
				if ( $letter eq 'a' ) {
					if ( $maxA > $val ) {
						if ( $minA > $val ) {
							# If the return is a function call
							if ( $ret =~ /[a-z]+/ ) {
								$retVal += getNumCom ($ret, $minX, $maxX, $minM, $maxM, $minA, $maxA, $minS, $maxS);
							}
							# otherwise, it's an A or R return
							else {
								if ( $ret eq 'A' ) {
									my $numX = ($maxX - $minX) + 1;
									my $numM = ($maxM - $minM) + 1;
									my $numA = ($maxA - $minA) + 1;
									my $numS = ($maxS - $minS) + 1;

									$retVal += $numX * $numM * $numA * $numS;
								}
								# This is a case where we've matched all parts (min > val), and we reject them all
								# Do not continue processing rules for these parts, and "return 0" for them
								else { last RULE; }
							}
						}
						else {
							# If the return is a function call
							if ( $ret =~ /[a-z]+/ ) {
								$retVal += getNumCom ($ret, $minX, $maxX, $minM, $maxM, $val+1, $maxA, $minS, $maxS);
							}
							# otherwise, it's an A or R return
							else {
								if ( $ret eq 'A' ) {
									my $numX = ($maxX - $minX) + 1;
									my $numM = ($maxM - $minM) + 1;
									my $numA = ($maxA - $val);
									my $numS = ($maxS - $minS) + 1;

									$retVal += $numX * $numM * $numA * $numS;
								}
							}
							# Move the max down for processing against remaining rules
							$maxA = $val;
						}
					}
				}
				if ( $letter eq 's' ) {
					if ( $maxS > $val ) {
						if ( $minS > $val ) {
							# If the return is a function call
							if ( $ret =~ /[a-z]+/ ) {
								$retVal += getNumCom ($ret, $minX, $maxX, $minM, $maxM, $minA, $maxA, $minS, $maxS);
							}
							# otherwise, it's an A or R return
							else {
								if ( $ret eq 'A' ) {
									my $numX = ($maxX - $minX) + 1;
									my $numM = ($maxM - $minM) + 1;
									my $numA = ($maxA - $minA) + 1;
									my $numS = ($maxS - $minS) + 1;

									$retVal += $numX * $numM * $numA * $numS;
								}
								# This is a case where we've matched all parts (min > val), and we reject them all
								# Do not continue processing rules for these parts, and "return 0" for them
								else { last RULE; }
							}
						}
						else {
							# If the return is a function call
							if ( $ret =~ /[a-z]+/ ) {
								$retVal += getNumCom ($ret, $minX, $maxX, $minM, $maxM, $minA, $maxA, $val+1, $maxS);
							}
							# otherwise, it's an A or R return
							else {
								if ( $ret eq 'A' ) {
									my $numX = ($maxX - $minX) + 1;
									my $numM = ($maxM - $minM) + 1;
									my $numA = ($maxA - $minA) + 1;
									my $numS = ($maxS - $val);

									$retVal += $numX * $numM * $numA * $numS;
								}
							}
							# Move the max down for processing against remaining rules
							$maxS = $val;
						}
					}
				}
			}
			if ( $comp eq '<' ) {
				if ( $letter eq 'x' ) {
					if ( $minX < $val ) {
						if ( $maxX < $val ) {
							# If the return is a function call
							if ( $ret =~ /[a-z]+/ ) {
								$retVal += getNumCom ($ret, $minX, $maxX, $minM, $maxM, $minA, $maxA, $minS, $maxS);
							}
							# otherwise, it's an A or R return
							else {
								if ( $ret eq 'A' ) {
									my $numX = ($maxX - $minX) + 1;
									my $numM = ($maxM - $minM) + 1;
									my $numA = ($maxA - $minA) + 1;
									my $numS = ($maxS - $minS) + 1;

									$retVal += $numX * $numM * $numA * $numS;
								}
								# The following else is a case where we've matched all parts (min > val), and we reject them all
								# Do not continue processing rules for these parts, and "return 0" for them
								else { last RULE; }
							}

						}
						else {
							# If the return is a function call
							if ( $ret =~ /[a-z]+/ ) {
								$retVal += getNumCom ($ret, $minX, $val-1, $minM, $maxM, $minA, $maxA, $minS, $maxS);
							}
							# otherwise, it's an A or R return
							else {
								if ( $ret eq 'A' ) {
									my $numX = ($val - $minX);
									my $numM = ($maxM - $minM) + 1;
									my $numA = ($maxA - $minA) + 1;
									my $numS = ($maxS - $minS) + 1;

									$retVal += $numX * $numM * $numA * $numS;
								}
							}
							# Move the min up for processing against remaining rules
							$minX = $val;
						}
					}
				}
				if ( $letter eq 'm' ) {
					if ( $minM < $val ) {
						if ( $maxM < $val ) {
							# If the return is a function call
							if ( $ret =~ /[a-z]+/ ) {
								$retVal += getNumCom ($ret, $minX, $maxX, $minM, $maxM, $minA, $maxA, $minS, $maxS);
							}
							# otherwise, it's an A or R return
							else {
								if ( $ret eq 'A' ) {
									my $numX = ($maxX - $minX) + 1;
									my $numM = ($maxM - $minM) + 1;
									my $numA = ($maxA - $minA) + 1;
									my $numS = ($maxS - $minS) + 1;

									$retVal += $numX * $numM * $numA * $numS;
								}
								# The following else is a case where we've matched all parts (min > val), and we reject them all
								# Do not continue processing rules for these parts, and "return 0" for them
								else { last RULE; }
							}

						}
						else {
							# If the return is a function call
							if ( $ret =~ /[a-z]+/ ) {
								$retVal += getNumCom ($ret, $minX, $maxX, $minM, $val-1, $minA, $maxA, $minS, $maxS);
							}
							# otherwise, it's an A or R return
							else {
								if ( $ret eq 'A' ) {
									my $numX = ($maxX - $minX) + 1;
									my $numM = ($val - $minM);
									my $numA = ($maxA - $minA) + 1;
									my $numS = ($maxS - $minS) + 1;

									$retVal += $numX * $numM * $numA * $numS;
								}
							}
							# Move the min up for processing against remaining rules
							$minM = $val;
						}
					}
				}
				if ( $letter eq 'a' ) {
					if ( $minA < $val ) {
						if ( $maxA < $val ) {
							# If the return is a function call
							if ( $ret =~ /[a-z]+/ ) {
								$retVal += getNumCom ($ret, $minX, $maxX, $minM, $maxM, $minA, $maxA, $minS, $maxS);
							}
							# otherwise, it's an A or R return
							else {
								if ( $ret eq 'A' ) {
									my $numX = ($maxX - $minX) + 1;
									my $numM = ($maxM - $minM) + 1;
									my $numA = ($maxA - $minA) + 1;
									my $numS = ($maxS - $minS) + 1;

									$retVal += $numX * $numM * $numA * $numS;
								}
								# The following else is a case where we've matched all parts (min > val), and we reject them all
								# Do not continue processing rules for these parts, and "return 0" for them
								else { last RULE; }
							}

						}
						else {
							# If the return is a function call
							if ( $ret =~ /[a-z]+/ ) {
								$retVal += getNumCom ($ret, $minX, $maxX, $minM, $maxM, $minA, $val-1, $minS, $maxS);
							}
							# otherwise, it's an A or R return
							else {
								if ( $ret eq 'A' ) {
									my $numX = ($maxX - $minX) + 1;
									my $numM = ($maxM - $minM) + 1;
									my $numA = ($val - $minA);
									my $numS = ($maxS - $minS) + 1;

									$retVal += $numX * $numM * $numA * $numS;
								}
							}
							# Move the min up for processing against remaining rules
							$minA = $val;
						}
					}
				}
				if ( $letter eq 's' ) {
					if ( $minS < $val ) {
						if ( $maxS < $val ) {
							# If the return is a function call
							if ( $ret =~ /[a-z]+/ ) {
								$retVal += getNumCom ($ret, $minX, $maxX, $minM, $maxM, $minA, $maxA, $minS, $maxS);
							}
							# otherwise, it's an A or R return
							else {
								if ( $ret eq 'A' ) {
									my $numX = ($maxX - $minX) + 1;
									my $numM = ($maxM - $minM) + 1;
									my $numA = ($maxA - $minA) + 1;
									my $numS = ($maxS - $minS) + 1;

									$retVal += $numX * $numM * $numA * $numS;
								}
								# The following else is a case where we've matched all parts (min > val), and we reject them all
								# Do not continue processing rules for these parts, and "return 0" for them
								else { last RULE; }
							}

						}
						else {
							# If the return is a function call
							if ( $ret =~ /[a-z]+/ ) {
								$retVal += getNumCom ($ret, $minX, $maxX, $minM, $maxM, $minA, $maxA, $minS, $val-1);
							}
							# otherwise, it's an A or R return
							else {
								if ( $ret eq 'A' ) {
									my $numX = ($maxX - $minX) + 1;
									my $numM = ($maxM - $minM) + 1;
									my $numA = ($maxA - $minA) + 1;
									my $numS = ($val - $minS);

									$retVal += $numX * $numM * $numA * $numS;
								}
							}
							# Move the min up for processing against remaining rules
							$minS = $val;
						}
					}
				}
			}
		}
		# if the rule unconditionally returns the result of a function
		elsif ( $rule =~ /^([a-z]+)$/ ) {
			my $ret = $1;
			$retVal += getNumCom ($ret, $minX, $maxX, $minM, $maxM, $minA, $maxA, $minS, $maxS);
		}
		# if the rule unconditionally returns the A or R
		elsif ( $rule =~ /^([AR])$/ ) {
			my $ret = $1;
			if ( $ret eq 'A' ) {
				my $numX = ($maxX - $minX) + 1;
				my $numM = ($maxM - $minM) + 1;
				my $numA = ($maxA - $minA) + 1;
				my $numS = ($maxS - $minS) + 1;

				if ( $debug > 1 ) {
					if ( $func eq "rfg" ) {
						print "$numX = ($maxX - $minX) + 1\n";
						print "$numM = ($maxM - $minM) + 1\n";
						print "$numA = ($maxA - $minA) + 1\n";
						print "$numS = ($maxS - $minS) + 1\n";
					}
				}
				$retVal += $numX * $numM * $numA * $numS;
			}
		}
		# if I missed some other rule format...
		else {
			print "Unmatched rule '", $rule, "' in function $func\n";
		}
	}
	print "Returning $retVal from $func\n" if ($debug > 0);
	return $retVal;
}