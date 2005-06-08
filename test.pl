#!/usr/bin/perl
#
# $Header: /Users/matisse/Desktop/CVS2GIT/matisse.net.cvs/Text-TagTemplate/Attic/test.pl,v 1.8 2005/06/08 01:36:37 matisse Exp $
#
##############################################################################

use strict;
use FindBin qw($Bin);
# use lib "$Bin";  # Add the current directory to the start of @INC

use Test::Harness qw( runtests $verbose );

$Test::Harness::verbose = 1;

my @tests;
if ($#ARGV >= 0) {
    while (my $testName  = shift @ARGV) {
        $testName .= ".t" unless ($testName =~ /\.t$/);
        push @tests, "$Bin/t/".$testName;
    }
} else {
    opendir(DIR, "t") || die "can't opendir test directory t: $!";
    while(defined (my $file = readdir(DIR)) ) {
        next unless ($file =~ /^.*?\.t$/) && (!($file =~ /^template/));
        push @tests, "$Bin/t/".$file;
    }
    closedir DIR;
}

runtests(@tests);

1;
