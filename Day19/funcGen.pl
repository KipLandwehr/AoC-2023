#!/usr/bin/perl
use warnings;
use strict;

my $debug = 0;
my $total = 0;

my %xmas2index = (
	'x' => 0,
	'm' => 1,
	'a' => 2,
	's' => 3,
);

print "use strict;\n\n";

while (<>) {
	chomp;
	last if $_ =~ /^$/;

	my ($funcName, $ruleStr) = $_ =~ /^([\w]+)\{(.*)\}$/;
	my @rules = split ',', $ruleStr;

	print "sub $funcName {\n";
	print "\tmy \$aRef = shift;\n";

	foreach my $rule ( @rules ) {
		# if the rule conditionally returns the result of a function or A or R
		if ( $rule =~ /^([xmas])([<>])([\d]+):([a-z]+|[AR])$/ ) {
			my $index = $xmas2index{$1};
			my $comp = $2;
			my $val = $3;
			my $ret = $4;

			print "\tif (\$\$aRef[$index] $comp $val) {\n";

			# If the return is a function call
			if ( $ret =~ /[a-z]+/ ) {
				print "\t\treturn $ret(\$aRef);\n";
			}
			# otherwise, it's an A or R return
			else {
				print "\t\treturn '$ret';\n";
			}

			print "\t}\n";
		}
		# if the rule unconditionally returns the result of a function
		elsif ( $rule =~ /^([a-z]+)$/ ) {
			my $ret = $1;
			print "\treturn $ret(\$aRef);\n";
		}
		# if the rule unconditionally returns the A or R
		elsif ( $rule =~ /^([AR])$/ ) {
			my $ret = $1;
			print "\treturn '$ret';\n";
		}
		# if I missed some other rule format...
		else {
			print "Unmatched rule '", $rule, "'on Input Line $.\n";
		}
	}

	print "}\n\n";
	print "1;";
}

# Example of desired output -

#	px{a<2006:qkq,m>2090:A,rfg}
#	sub px {
#		my $aRef = shift;
#		if ($$aRef[2]<2006) {
#			return qkq($aRef);
#		}
#		if ($$aRef[1]>2090) {
#			return 'A';
#		}
#		return rfg($aRef);
#	}