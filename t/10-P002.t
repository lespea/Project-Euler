#!perl -T

use strict;
use warnings;
use autodie;
use List::Util qw/sum/;
use Test::More;


use constant MODULE => 'Project::Euler::Problem::P002';

sub qc {
    my ($nums, $max) = @_;
    my %num_list;

    for  my $num  (@$nums) {
        for (my $i = $num; $i < $max; $i += $num) {
            $num_list{$i} = 1;
        }
    }

    return sum(keys %num_list);
}


my @ok_tests = (
    [
        undef,
        [0,      0],
        [1,      0],
        [2,      0],
        [3,      2],
        [4,      2],
        [5,      2],
        [10,    10],
        [20,    10],
        [30,    10],
        [40,    44],
        [50,    44],
        [100,   44],
        [200,  188],
        [300,  188],
        [400,  188],
        [500,  188],
        [1000, 188],

        [4_000_000, 4613732],
    ]
);

my @nok_tests = (
);


my $sum;
for  my $test_array  (grep {scalar @$_ > 0} (\@ok_tests, \@nok_tests)) {
    ($sum += scalar @$_ * 2)  for  @$test_array;
}

plan tests => 2 + $sum;
diag( 'Checking specific P001 problems' );


use_ok( MODULE );
my $problem    = new_ok( MODULE );
my $def_multis = $problem->multi_nums();

$problem->use_defaults(0);


for  my $test  (@ok_tests) {
    my $ref = shift @$test;
    my $divs;

    if (ref $ref eq q{}) {
        $problem->multi_nums($def_multis);
        $divs = sprintf('[%s]', join ',', @$def_multis);
    }
    elsif (ref $ref eq q{ARRAY}) {
        $problem->multi_nums($ref);
        $divs = sprintf('[%s]', join ',', @$ref);
    }
    else {
        die "Bad ref type: " . ref $ref;
    }


    for  my $tests  (@$test) {
        my ($in, $out) = @$tests;

        $problem->max_number($in);
        $problem->custom_answer($out);

        my $answer = $problem->solve();
        my $status = $problem->solved_status();

        ok($status, sprintf('Status should be okay for input %s => %d -> %d',
                $divs, $in, $out));
        is($out, $answer, sprintf('Bad return answer for %s => %d -> %d',
                $divs, $in, $out));
    }
}
