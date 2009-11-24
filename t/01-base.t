package base_test_input;
use Moose;
with 'Project::Euler::Problem::Base';
sub _build_problem_number { return 1                 }
sub _build_problem_name   { return q{Template Name}  }
sub _build_problem_date   { return q{2012-12-21}     }
sub _build_problem_desc   { return q{Blah blah blah} }
sub _build_default_input  { return q{42}             }
sub _build_default_answer { return '42'              }
sub _build_help_message   { return q{Help me}        }
sub _check_input          { return 1                 }
#has '+has_input' => (default => 0);

sub _solve_problem {
    my ($self, $arg) = @_;
    
    if ($self->has_input) {
        return $arg;
    }
    else {
        return $self->default_answer;
    }
}
no Moose;
__PACKAGE__->meta->make_immutable;


package base_test_noinput;
use Moose;
with 'Project::Euler::Problem::Base';
sub _build_problem_number { return 1                 }
sub _build_problem_name   { return q{Template Name}  }
sub _build_problem_date   { return q{2012-12-21}     }
sub _build_problem_desc   { return q{Blah blah blah} }
sub _build_default_input  { return q{}               }
sub _build_default_answer { return '42'              }
sub _build_help_message   { return q{Help me}        }
sub _check_input          { return 1                 }
has '+has_input' => (default => 0);

sub _solve_problem {
    my ($self, $arg) = @_;
    
    if ($self->has_input) {
        return $arg;
    }
    else {
        return $self->default_answer;
    }
}
no Moose;
__PACKAGE__->meta->make_immutable;



package test;

use strict;
use warnings;
use Test::More;

use Readonly;

Readonly::Scalar my $BASE_URL => q{http://projecteuler.net/index.php?section=problems&id=};

plan tests => 3 + 7 + (3 * 3) + 1;
diag( 'Base class is functioning correctly' );

my $t_in  = new_ok( 'base_test_input'   );
my $t_nin = new_ok( 'base_test_noinput' );
my $t_inc = new_ok( 'base_test_input'   );

my $cus_input = 54;
$t_inc->custom_input( $cus_input) ;

$t_in->use_defaults(  1 );
$t_inc->use_defaults( 0 );
$t_nin->use_defaults( 1 );


is( $t_in->problem_name     , q{Template Name} , 'problem_name is set correctly'   );
is( $t_in->problem_date->ymd, q{2012-12-21}    , 'problem_date is set correctly'   );
is( $t_in->problem_desc     , q{Blah blah blah}, 'problem_desc is set correctly'   );
is( $t_in->problem_link     , $BASE_URL . '1'  , 'problem_link is set correctly'   );
is( $t_in->default_input    , q{42}            , 'default_input is set correctly'  );
is( $t_in->default_answer   , q{42}            , 'default_answer is set correctly' );
is( $t_in->help_message     , q{Help me}       , 'help_message is set correctly'   );


for  my $module  ($t_in, $t_inc, $t_nin) {
    my ($status, $answer, $required) = $module->solve;

    my $last_answer = $module->solve_answer;
    my $last_status = $module->solve_status;

    is( $status, $last_status, 'Status returned and object status should be equal' );
    is( $answer, $last_answer, 'Answer returned and object answer should be equal' );

    if ($module->use_defaults) {
        is( $answer, $required, 'Answer returned and required answer should be equal for the default input' );
    }
    else {
        isnt( $answer, $required,  'Answer and required should not be equal for the custom input' );
        is(   $answer, $cus_input, 'Answer and custom input should be equal' );
    }
}
