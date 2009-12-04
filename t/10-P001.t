#!perl -T

use strict;
use warnings;
use autodie;
use Test::More;

use constant MODULE => 'Project::Euler::Problem::P001';

my @ok_tests = (
    [qw/  /],
);

my @nok_tests = (
    [qw/  /],
);

plan tests => 2 + scalar @ok_tests + scalar @nok_tests;
diag( 'Checking specific P001 problems' );

use_ok( MODULE );
my $problem = new_ok( MODULE );

for  my $test  (@ok_tests) {
    my ($in, $out) = @$test;
    $problem->
}
