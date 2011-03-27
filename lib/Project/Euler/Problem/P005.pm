use strict;
use warnings;
use utf8;

package Project::Euler::Problem::P005;

## no critic 'Subroutines::ProhibitUnusedPrivateSubroutines'

use Carp;
use Modern::Perl;
use Moose;

use Math::BigInt qw/ blcm /;
with 'Project::Euler::Problem::Base';


#ABSTRACT: Solutions for problem 005 - Least common multiple


=encoding utf8

=head1 HOMEPAGE

L<http://projecteuler.net/index.php?section=problems&id=5|http://projecteuler.net/index.php?section=problems&id=5>


=head1 SYNOPSIS

    use Project::Euler::Problem::P005;
    my $p5 = Project::Euler::Problem::P005->new;

    my $default_answer = $p5->solve;

=head1 DESCRIPTION

This module is used to solve problem #005

Use Math::BigInt to calculate the least common multiple between numbers

=head1 SETUP

=head2 Problem Number

    005

=cut

sub _build_problem_number {
    #  Must be an int > 0
    return 5;
}


=head2 Problem Name

    Least common multiple

=cut

sub _build_problem_name {
    return q{Smallest all_div number};
}


=head2 Problem Date

    30 November 2001

=cut

sub _build_problem_date {
    return q{30 November 2001};
}


=head2 Problem Desc

2520 is the smallest number that can be divided by each of the numbers from 1
to 10 without any remainder.What is the smallest number that is evenly
divisible by all of the numbers from 1 to 20?

=cut

sub _build_problem_desc {
    return <<'__END_DESC';

2520 is the smallest number that can be divided by each of the numbers from 1
to 10 without any remainder.What is the smallest number that is evenly
divisible by all of the numbers from 1 to 20?

__END_DESC
}


=head2 Default Input

20

=cut

sub _build_default_input {
    return 20;
}


=head2 Default Answer

    232792560

=cut

sub _build_default_answer {
    return 232_792_560;
}


=head2 Has Input?

    Yes

=cut

#has '+has_input' => (default => 0);


=head2 Help Message

The input controls the cap of the range of numbers to find the least common
multiple of.

=cut

sub _build_help_message {

    return <<'__END_HELP';

The input controls the cap on of the range of numbers to find the least common
multiple of.

__END_HELP

}



=head1 INTERNAL FUNCTIONS

=head2 Validate Input

The restrictions on custom_input

    A positve integer

=cut

sub _check_input {
      my ( $self, $input, ) = @_;

      if ($input !~ /\D/xms or $input < 1) {
          croak sprintf q{Your input, '%s', must be all digits and >= 1}, $input;
      }
}



=head2 Solving the problem

This is just goes from the largest multi_num until multiple_check returns true
and returns that number.

This is like P3 in that it's definitely cheating and will have to be re-written
with custom logic (even though it will almost certainly be much slower)

=cut

sub _solve_problem {
    my ($self, $max) = @_;

    $max //= $self->default_input;

    return blcm(1..$max)->numify;
}



=head1 SEE ALSO

Math::BigInt

=cut

__PACKAGE__->meta->make_immutable;
1; # End of Project::Euler::Problem::P005
