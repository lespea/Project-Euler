#!perl -T

use strict;
use warnings;

use Test::Most;
use Project::Euler::Lib::Utils qw/ :list /;

my @ok_some = (1, 0,
    [10, [1]],
    [10, [2]],
    [10, [10]],
    [10, [2, 3]],
    [10, [2, 3, 10]],
    [10, [2, 3, 11]],
);

my @ok_all = (1, 1,
    [10, [1]],
    [10, [2]],
    [10, [10]],
    [10, [2, 5]],
    [10, [2, 5, 10]],
);

my @nok_some = (0, 0,
    [10, [3]],
    [10, [4]],
    [10, [11]],
    [10, [3, 4]],
    [10, [3, 7]],
    [10, [3, 11]],
);

my @nok_all = (0, 1,
    [10, [3]],
    [10, [4]],
    [10, [11]],
    [10, [2, 4]],
    [10, [2, 3]],
    [10, [2, 3, 10]],
    [10, [2, 3, 11]],
);

plan tests => @ok_some + @ok_all + @nok_some + @nok_all - (4*2);

for  my $test_ref  (\@ok_some, \@ok_all, \@nok_some, \@nok_all) {
    my ($status, $all, @tests) = @$test_ref;

    for  my $test  (@tests) {
        my ($val, $filter_ref) = @$test;
        my $str = sprintf("%d should%s have been filtered by the%s array '%s'",
                            $val,
                            $status ? '' : ' not',
                            $all ? ' entire' : '',
                            join ',',@$filter_ref
                        );

        is( multiple_check( $val, $filter_ref, $all ), $status, $str );
    }
}
