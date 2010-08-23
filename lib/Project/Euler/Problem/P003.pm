use strict;
use warnings;
package Project::Euler::Problem::P003;

use Carp;
use Modern::Perl;
use Moose;

use Math::Big::Factors qw/ factors_wheel /;

with 'Project::Euler::Problem::Base';


#ABSTRACT: Solutions for problem 003 - Max prime factor


=head1 HOMEPAGE

L<< http://projecteuler.net/index.php?section=problems&id=3 >>

=head1 SYNOPSIS

    use Project::Euler::Problem::P003;
    my $p3 = Project::Euler::Problem::P003->new;

    my $default_answer = $p3->solve;

=head1 DESCRIPTION

This module is used to solve problem #003

Here we find the maximum prime factor of a given number.  Math::Big::Factor is
used to generate a prime wheel that finds all of the prime factors.  From there
it's a simple matter of taking the last one in the array to find the max value.

=head1 Problem Attributes

*None*

=cut


=head1 SETUP

=head2 Problem Number

    003

=cut

sub _build_problem_number {
    #  Must be an int > 0
    return 3;
}


=head2 Problem Name

    Max prime factor

=cut

sub _build_problem_name {
    return q{Max prime factor};
}


=head2 Problem Date

    02 November 2001

=cut

sub _build_problem_date {
    return q{02 November 2001};
}


=head2 Problem Desc

The prime factors of 13195 are 5, 7, 13 and 29.What is the largest prime factor
of the number 600,851,475,143?

=cut

sub _build_problem_desc {
    return <<'__END_DESC';

The prime factors of 13195 are 5, 7, 13 and 29.What is the largest prime factor
of the number 600,851,475,143?

__END_DESC
}


=head2 Default Input

600,851,475,143

=cut

sub _build_default_input {
    return 600_851_475_143;
}


=head2 Default Answer

    6857

=cut

sub _build_default_answer {
    return 6857;
}


=head2 Has Input?

    Yes

=cut
#has '+has_input' => (default => 0);


=head2 Help Message

There is little to no customization for this problem, simply tell it what you
want to factor with custom_input

=cut

sub _build_help_message {

    return <<'__END_HELP';

There is little to no customization for this problem, simply tell it what you
want to factor with custom_input

__END_HELP

}



=head1 INTERNAL FUNCTIONS

=head2 Validate Input

The restrictions on custom_input

    A positive integer

=cut

sub _check_input {
    my ( $self, $input, ) = @_;

    if ($input !~ /\D/ or $input < 1) {
        croak sprintf(q{Your input, '%s', must be all digits and >= 1}, $input);
    }
}




=head2 Solving the problem

Use factors_wheel to find all of the prime factors for the given number.  Since
the function always returns a sorted list, we can just return the last number
in the returned array to find the max.  In order to speed up the function
whenever possible, a smaller wheel is generated if the number is less than 10
characters long

=cut

sub _solve_problem {
    my ($self, $max) = @_;

    $max //= $self->default_input;

    my $wheel_size  = length $max < 10  ?  6  :  7;

    #  Cheat a little bit since we know the default input works fine with
    #  a wheel size of 5 so use that since it's crazy fast.
    $wheel_size = 5  if  $self->default_input;

    my @factors = factors_wheel($max, $wheel_size);

    $self->_set_more_info(sprintf('The factors were %s', join q{, }, @factors));
    return $factors[-1]->numify;
}


__PACKAGE__->meta->make_immutable;
1; # End of Project::Euler::Problem::P003
