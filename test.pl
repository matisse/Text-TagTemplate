# Before `make install' is performed this script should be runnable with
# `make test'. After `make install' it should work as `perl test.pl'

######################### We start with some black magic to print on failure.

# Change 1..1 below to 1..last_test_to_print .
# (It may become useful if the test is moved to ./t subdirectory.)

BEGIN { $| = 1; print "1..65\n"; }
END {print "not ok 1\n" unless $loaded;}
use Text::TagTemplate;
$loaded = 1;
print "ok\n";

######################### End of black magic.

# Insert your test code below (better if it prints "ok 13"
# (correspondingly "not ok 13") depending on the success of chunk 13
# of the test code):

my $out;

print "Create a new object\n";
my $t = new Text::TagTemplate;
print "ok\n";

print "Create a new object with tags in a hash.\n";
my $t2 = new Text::TagTemplate( 1 => 2, 3 => 4 );
print "ok\n";

print "Create a new object with tags in a hashref.\n";
my $t3 = new Text::TagTemplate( +{ 1 => 2, 3 => 4 } );
print "ok\n";

print "Return auto_cap value: ", $t->auto_cap, "\n";
print "ok\n";

print "Set auto_cap value.\n";
$t->auto_cap( 1 );
print "ok\n";

print "Return unknown_action value: ", $t->unknown_action, "\n";
print "ok\n";

print "Set unknown_action value.\n";
$t->unknown_action( 'foo' );
print "ok\n";

print "Return the tags in the t2 template: ", join( ' ', sort %{ $t2->tags } ), "\n";
if ( join( ' ', sort %{ $t2->tags } ) ne '1 2 3 4' ) {
	print "not ok\n";
} else {
	print "ok\n";
}

print "Return the tags in the t3 template: ", join( ' ', sort %{ $t3->tags } ), "\n";
if ( join( ' ', sort %{ $t3->tags } ) ne '1 2 3 4' ) {
	print "not ok\n";
} else {
	print "ok\n";
}

print "Set the tags in the template.\n";
$t->tags( 1 => 2, 3 => 4 );
print "ok\n";

print "Return the tags in the template: ", join( ' ', sort %{ $t->tags } ), "\n";
if ( join( ' ', sort %{ $t->tags } ) ne '1 2 3 4' ) {
	print "not ok\n";
} else {
	print "ok\n";
}

print "Add a single tag.\n";
$t->add_tag( 5 => 6 );
print "ok\n";

print "Add a single list tag.\n";
$t->add_list_tag( L, +[ 1, 2, 3, 4, 5 ], sub { return +{ N => $_[ 0 ] } } );
print "ok\n";

undef $out;
print "Test this list tag: ";
$out = $t->parse( 'L: <#L ENTRY_FILE="test-entry.htmlf">' );
print $out;

print "Delete the list tag.\n";
$t->delete_tag( 'L' );
print "ok\n";

print "Add a bunch of tags as a hash.\n";
$t->add_tags( 7 => 8, 9 => A );
print "ok\n";

print "Add a bunch of tags as a hashref.\n";
$t->add_tags( +{ B => C, D => E } );
print "ok\n";

print "Check we added those OK: ", join( ' ', sort %{ $t->tags } ), "\n";
if ( join( ' ', sort %{ $t->tags } ) ne '1 2 3 4 5 6 7 8 9 A B C D E' ) {
	print "not ok\n";
} else {
	print "ok\n";
}

print "Delete tag.\n";
$t->delete_tag( 1 );
print "ok\n";

print "Check that we deleted it: ", join( ' ', sort %{ $t->tags } ), "\n";
if ( join( ' ', sort %{ $t->tags } ) ne '3 4 5 6 7 8 9 A B C D E' ) {
	print "not ok\n";
} else {
	print "ok\n";
}

print "Clear tags.\n";
$t->clear_tags;
print "ok\n";

print "Check we cleared them: ", join( ' ', sort %{ $t->tags } ), "\n";
if ( %{ $t->tags } ) {
	print "not ok\n";
} else {
	print "ok\n";
}

print "Check setting the list.\n";
$t->list( '1', '2', '3', '4', '5' );
print "ok\n";

print "Check returning the list: ", join( ' ', $t->list ), "\n";
if ( join( ' ', $t->list ) ne '1 2 3 4 5' ) {
	print "not ok\n";
} else {
	print "ok\n";
}

print "Check setting the template string.\n";
$t->template_string( '1: <#1>, 3: <#3>' );
print "ok\n";

print "Check returning the template string: ", $t->template_string, "\n";
if ( $t->template_string ne '1: <#1>, 3: <#3>' ) {
	print "not ok\n";
} else {
	print "ok\n";
}

print "Check setting the template file.\n";
$t->template_file( 'test.html' );
print "ok\n";

print "Check returning the template file: ", $t->template_file, "\n";
if ( $t->template_file ne 'test.html' ) {
	print "not ok\n";
} else {
	print "ok\n";
}

print "Check setting the entry string.\n";
$t->entry_string( 'N: <#N>' );
print "ok\n";

print "Check returning the entry string: ", $t->entry_string, "\n";
if ( $t->entry_string ne 'N: <#N>' ) {
	print "not ok\n";
} else {
	print "ok\n";
}

print "Check setting the entry file.\n";
$t->entry_file( 'test-entry.htmlf' );
print "ok\n";

print "Check returning the entry file: ", $t->entry_file, "\n";
if ( $t->entry_file ne 'test-entry.htmlf' ) {
	print "not ok\n";
} else {
	print "ok\n";
}

print "Check setting the entry callback.\n";
$t->entry_callback( sub { return +{ N => $_[ 0 ] } } );
print "ok\n";

print "Check returning the entry callback: ", $t->entry_callback, "\n";
if ( ref( $t->entry_callback ) ne 'CODE' ) {
	print "not ok\n";
} else {
	print "ok\n";
}

print "Check setting the join string.\n";
$t->join_string( ', ' );
print "ok\n";

print "Check returning the join string: ", $t->join_string, "\n";
if ( $t->join_string ne ', ' ) {
	print "not ok\n";
} else {
	print "ok\n";
}

print "Check setting the join file.\n";
$t->join_file( 'test-join.htmlf' );
print "ok\n";

print "Check returning the join file: ", $t->join_file, "\n";
if ( $t->join_file ne 'test-join.htmlf' ) {
	print "not ok\n";
} else {
	print "ok\n";
}

print "Check setting the join tags with a hash.\n";
$t->join_tags( 1 => 2, 3 => 4 );
print "ok\n";

print "Check setting the join tags with a hashref.\n";
$t->join_tags( 1 => 2, 3 => 4 );
print "ok\n";

print "Check returning the join tags: ", join( ' ', sort %{ $t->join_tags } ), "\n";
if ( join( ' ', sort %{ $t->join_tags } ) ne '1 2 3 4' ) {
	print "not ok\n";
} else {
	print "ok\n";
}

print "Resetting tags to 1 => 2, 3 => 4.\n";
$t->tags( 1 => 2, 3 => 4 );

undef $out;
print "Check parsing using the template string previously given: ";
$out = $t->parse;
print $out, "\n";
if ( $out ne '1: 2, 3: 4' ) {
	print "not ok\n";
} else {
	print "ok\n";
}

undef $out;
print "Check parsing using template string supplied to function: ";
$out = $t->parse( '1: <#1>, 3: <#3>' );
print $out, "\n";
if ( $out ne '1: 2, 3: 4' ) {
	print "not ok\n";
} else {
	print "ok\n";
}

undef $out;
print "Check parsing using template string and hash of tags supplied to function: ";
$out = $t->parse( '5: <#5>, 7: <#7>', 5 => 6, 7 => 8 );
print $out, "\n";
if ( $out ne '5: 6, 7: 8' ) {
	print "not ok\n";
} else {
	print "ok\n";
}

undef $out;
print "Check parsing using template string and hashref of tags supplied to function: ";
$out = $t->parse( '9: <#9>, B: <#B>', +{ 9 => A, B => C } );
print $out, "\n";
if ( $out ne '9: A, B: C' ) {
	print "not ok\n";
} else {
	print "ok\n";
}

undef $out;
print "Check parsing using template file previously given: ";
$out = $t->parse_file;
print $out;
if ( $out ne "1: 2, 3: 4\n" ) {
	print "not ok\n";
} else {
	print "ok\n";
}

undef $out;
print "Check parsing using template file supplied to function: ";
$out = $t->parse_file( 'test.html' );
print $out;
if ( $out ne "1: 2, 3: 4\n" ) {
	print "not ok\n";
} else {
	print "ok\n";
}

undef $out;
print "Check parsing using template file and hash of tags supplied to function: ";
$out = $t->parse_file( 'test.html', 1 => 2, 3 => 4 );
print $out;
if ( $out ne "1: 2, 3: 4\n" ) {
	print "not ok\n";
} else {
	print "ok\n";
}

undef $out;
print "Check parsing using template file and hashref of tags supplied to function: ";
$out = $t->parse_file( 'test.html', +{ 1 => 2, 3 => 4 } );
print $out;
if ( $out ne "1: 2, 3: 4\n" ) {
	print "not ok\n";
} else {
	print "ok\n";
}

undef $out;
print "Check parsing list using previously supplied list etc: ";
$out = $t->parse_list;
print $out, "\n";
if ( $out ne 'N: 1, N: 2, N: 3, N: 4, N: 5' ) {
	print "not ok\n";
} else {
	print "ok\n";
}

undef $out;
print "Check parsing list using listref supplied to function: ";
$out = $t->parse_list( +[ 6, 7, 8, 9, A ] );
print $out, "\n";
if ( $out ne 'N: 6, N: 7, N: 8, N: 9, N: A' ) {
	print "not ok\n";
} else {
	print "ok\n";
}

undef $out;
print "Check parsing list using listref and entry string supplied to function: ";
$out = $t->parse_list( +[ 6, 7, 8, 9, A ], 'M: <#N>' );
print $out, "\n";
if ( $out ne 'M: 6, M: 7, M: 8, M: 9, M: A' ) {
	print "not ok\n";
} else {
	print "ok\n";
}

undef $out;
print "Check parsing list using listref and entry string and join string supplied to function: ";
$out = $t->parse_list( +[ 6, 7, 8, 9, A ], 'O: <#N>', '; ' );
print $out, "\n";
if ( $out ne 'O: 6; O: 7; O: 8; O: 9; O: A' ) {
	print "not ok\n";
} else {
	print "ok\n";
}

undef $out;
print "Check parsing list using listref and entry string and join string and entry callback supplied to function: ";
$out = $t->parse_list( +[ 6, 7, 8, 9, A ], 'P: <#P>', '; ', sub { return +{ P => $_[ 0 ] } } );
print $out, "\n";
if ( $out ne 'P: 6; P: 7; P: 8; P: 9; P: A' ) {
	print "not ok\n";
} else {
	print "ok\n";
}

undef $out;
print "Check parsing list using listref and entry string and join string and entry callback and join tags supplied as hash to function: ";
$out = $t->parse_list( +[ 6, 7, 8, 9, A ], 'P: <#P>', '-1: <#1>, 3: <#3>-', sub { return +{ P => $_[ 0 ] } }, 1 => 2, 3 => 4 );
print $out, "\n";
if ( $out ne 'P: 6-1: 2, 3: 4-P: 7-1: 2, 3: 4-P: 8-1: 2, 3: 4-P: 9-1: 2, 3: 4-P: A' ) {
	print "not ok\n";
} else {
	print "ok\n";
}

undef $out;
print "Check parsing list using listref and entry string and join string and entry callback and join tags supplied as hashref to function: ";
$out = $t->parse_list( +[ 6, 7, 8, 9, A ], 'P: <#P>', '-1: <#1>, 3: <#3>-', sub { return +{ P => $_[ 0 ] } }, +{ 1 => 2, 3 => 4 } );
print $out, "\n";
if ( $out ne 'P: 6-1: 2, 3: 4-P: 7-1: 2, 3: 4-P: 8-1: 2, 3: 4-P: 9-1: 2, 3: 4-P: A' ) {
	print "not ok\n";
} else {
	print "ok\n";
}

undef $out;
print "Check parsing list files using previously supplied list etc:\n";
$out = $t->parse_list_files;
print $out;
if ( $out ne <<'EOT' ) {
N: 1
1: 2, 3: 4
N: 2
1: 2, 3: 4
N: 3
1: 2, 3: 4
N: 4
1: 2, 3: 4
N: 5
EOT
	print "not ok\n";
} else {
	print "ok\n";
}

undef $out;
print "Check parsing list files using listref supplied to function:\n";
$out = $t->parse_list_files( +[ 6, 7, 8, 9, A ] );
print $out;
if ( $out ne <<'EOT' ) {
N: 6
1: 2, 3: 4
N: 7
1: 2, 3: 4
N: 8
1: 2, 3: 4
N: 9
1: 2, 3: 4
N: A
EOT
	print "not ok\n";
} else {
	print "ok\n";
}

undef $out;
print "Check parsing list files using listref and entry file supplied to function:\n";
$out = $t->parse_list_files( +[ 6, 7, 8, 9, A ], 'test-entry.htmlf' );
print $out;
if ( $out ne <<'EOT' ) {
N: 6
1: 2, 3: 4
N: 7
1: 2, 3: 4
N: 8
1: 2, 3: 4
N: 9
1: 2, 3: 4
N: A
EOT
	print "not ok\n";
} else {
	print "ok\n";
}

undef $out;
print "Check parsing list files using listref and entry file and join file supplied to function:\n";
$out = $t->parse_list_files( +[ 6, 7, 8, 9, A ], 'test-entry.htmlf', 'test-join.htmlf' );
print $out;
if ( $out ne <<'EOT' ) {
N: 6
1: 2, 3: 4
N: 7
1: 2, 3: 4
N: 8
1: 2, 3: 4
N: 9
1: 2, 3: 4
N: A
EOT
	print "not ok\n";
} else {
	print "ok\n";
}

undef $out;
print "Check parsing list files using listref and entry file and join file and entry callback supplied to function:\n";
$out = $t->parse_list_files( +[ 6, 7, 8, 9, A ], 'test-entry.htmlf', 'test-join.htmlf', sub { return +{ N => $_[ 0 ] } } );
print $out;
if ( $out ne <<'EOT' ) {
N: 6
1: 2, 3: 4
N: 7
1: 2, 3: 4
N: 8
1: 2, 3: 4
N: 9
1: 2, 3: 4
N: A
EOT
	print "not ok\n";
} else {
	print "ok\n";
}

undef $out;
print "Check parsing list files using listref and entry file and join file and entry callback and join tags supplied as hash to function:\n";
$out = $t->parse_list_files( +[ 6, 7, 8, 9, A ], 'test-entry.htmlf', 'test-join.htmlf', sub { return +{ N => $_[ 0 ] } }, 1 => 2, 3 => 4 );
print $out;
if ( $out ne <<'EOT' ) {
N: 6
1: 2, 3: 4
N: 7
1: 2, 3: 4
N: 8
1: 2, 3: 4
N: 9
1: 2, 3: 4
N: A
EOT
	print "not ok\n";
} else {
	print "ok\n";
}

undef $out;
print "Check parsing list files using listref and entry file and join file and entry callback and join tags supplied as hashref to function:\n";
$out = $t->parse_list_files( +[ 6, 7, 8, 9, A ], 'test-entry.htmlf', 'test-join.htmlf', sub { return +{ N => $_[ 0 ] } }, +{ 1 => 2, 3 => 4 } );
print $out;
if ( $out ne <<'EOT' ) {
N: 6
1: 2, 3: 4
N: 7
1: 2, 3: 4
N: 8
1: 2, 3: 4
N: 9
1: 2, 3: 4
N: A
EOT
	print "not ok\n";
} else {
	print "ok\n";
}

undef $out;
print "Checking setting the unknown_action to IGNORE: ";
$t->unknown_action( 'IGNORE' );
$out = $t->parse( qq{W: <#W P="Space: Tab:\tCR:\nLT:&lt;GT:&gt;Equals:&#061;Amp:&amp;Quote:&quot;">} );
print $out, "\n";
if ( $out ne qq{W: <#W P="Space: Tab:\tCR:\nLT:&lt;GT:&gt;Equals:&#061;Amp:&amp;Quote:&quot;">} ) {
	print "not ok\n";
} else {
	print "ok\n";
}

undef $out;
print "Check that parameters with whitespace and interesting characters are handled right.\n";
$t->add_tag( W => sub {
	my %params = %{ $_[ 0 ] };
	return $params{ P };
} );
$out = $t->parse( qq{W: <#W P="Space: Tab:\tCR:\nLT:&lt;GT:&gt;Equals:&#061;Amp:&amp;Quote:&quot;">} );
print $out, "\n";
if ( $out ne qq{W: Space: Tab:\tCR:\nLT:<GT:>Equals:=Amp:&Quote:"} ) {
	print "not ok\n";
} else {
	print "ok\n";
}

