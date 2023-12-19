use strict;

sub px {
	my $aRef = shift;
	if ($$aRef[2] < 2006) {
		return qkq($aRef);
	}
	if ($$aRef[1] > 2090) {
		return 'A';
	}
	return rfg($aRef);
}

sub pv {
	my $aRef = shift;
	if ($$aRef[2] > 1716) {
		return 'R';
	}
	return 'A';
}

sub lnx {
	my $aRef = shift;
	if ($$aRef[1] > 1548) {
		return 'A';
	}
	return 'A';
}

sub rfg {
	my $aRef = shift;
	if ($$aRef[3] < 537) {
		return gd($aRef);
	}
	if ($$aRef[0] > 2440) {
		return 'R';
	}
	return 'A';
}

sub qs {
	my $aRef = shift;
	if ($$aRef[3] > 3448) {
		return 'A';
	}
	return lnx($aRef);
}

sub qkq {
	my $aRef = shift;
	if ($$aRef[0] < 1416) {
		return 'A';
	}
	return crn($aRef);
}

sub crn {
	my $aRef = shift;
	if ($$aRef[0] > 2662) {
		return 'A';
	}
	return 'R';
}

sub in {
	my $aRef = shift;
	if ($$aRef[3] < 1351) {
		return px($aRef);
	}
	return qqz($aRef);
}

sub qqz {
	my $aRef = shift;
	if ($$aRef[3] > 2770) {
		return qs($aRef);
	}
	if ($$aRef[1] < 1801) {
		return hdj($aRef);
	}
	return 'R';
}

sub gd {
	my $aRef = shift;
	if ($$aRef[2] > 3333) {
		return 'R';
	}
	return 'R';
}

sub hdj {
	my $aRef = shift;
	if ($$aRef[1] > 838) {
		return 'A';
	}
	return pv($aRef);
}

1;
