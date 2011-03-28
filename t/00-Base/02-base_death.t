use strict;
use warnings;
use utf8;


package base_test_bad;
use Moose;
with 'Project::Euler::Problem::Base';
sub _build_problem_number { return 'a'               }
sub _build_problem_name   { return q{123456789}      }
sub _build_problem_date   { return q{2001-23-43}     }
sub _build_problem_desc   { return undef             }
sub _build_default_input  { return undef             }
sub _build_default_answer { return undef             }
sub _build_help_message   { return undef             }
sub _check_input          { return 0                 }

sub _solve_problem {
    return 1;
}
no Moose;
__PACKAGE__->meta->make_immutable;




package test;

use strict;
use warnings;
use Test::Most;
use Test::Exception;

use Const::Fast;

const  my $BASE_URL => q{http://projecteuler.net/index.php?section=problems&id=};
const  my $CUSTOM_INPUT  => 54;
const  my $CUSTOM_ANSWER => $CUSTOM_INPUT / 2;


plan tests => 2 + 7;

die_on_fail;

# TESTS -> 2
my $t_bad = new_ok( 'base_test_bad'     );

$t_bad->use_defaults( 0 );

throws_ok { $t_bad->solve }  qr/tried.*custom.*not.*set.*yet/i, "Can't solve a custom problem without setting the answer!";

# TESTS -> 7
dies_ok { $t_bad->problem_name   }  'problem_name is set correctly';
dies_ok { $t_bad->problem_date   }  'problem_date is set correctly';
dies_ok { $t_bad->problem_desc   }  'problem_desc is set correctly';
dies_ok { $t_bad->problem_link   }  'problem_link is set correctly';
dies_ok { $t_bad->default_input  }  'default_input is set correctly';
dies_ok { $t_bad->default_answer }  'default_answer is set correctly';
dies_ok { $t_bad->help_message   }  'help_message is set correctly';
