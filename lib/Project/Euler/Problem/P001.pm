use strict;
use warnings;
use utf8;

package Project::Euler::Problem::P001;

## no critic 'Subroutines::ProhibitUnusedPrivateSubroutines'

use Modern::Perl;
use namespace::autoclean;

use Moose;
use Carp;

with 'Project::Euler::Problem::Base';

use Project::Euler::Lib::Types  qw/ PosInt  PosIntArray /;
use Project::Euler::Lib::Utils  qw/ multiple_check /;

use List::Util  qw/ sum /;


#ABSTRACT: Solutions for problem 001 - Sum filtered range

=encoding utf8

=head1 HOMEPAGE

L<http://projecteuler.net/index.php?section=problems&id=1|http://projecteuler.net/index.php?section=problems&id=1>


=head1 SYNOPSIS

    use Project::Euler::Problem::P001;
    my $p1 = Project::Euler::Problem::P001->new;

    my $default_answer = $p1->solve;

    #  Use the default filter list of '3, 5'
    $p1->solve(11);  #  3 + 5 + 6 + 9 + 10  ==  33

    #  Didn't override the default answer so status is false!
    $p1->status;  # 0


    #  Change the filter list
    $p1->multi_nums( [4] );
    $p1->solve(25, 84);  #  4, 8, 12, 16, 20, 24  ==  84

    #  Overrode the default answer with the right one so the status is true
    $p1->status;  # 1


=head1 DESCRIPTION

This module is used to solve problem #001

This problem simply needs to find the sum of all the numbers within a range
which are multiples of a set of integers.  The range always starts at 1 and
continues B<up to> the provided input I<(1000 by default)>.  The numbers are
filtered using L<Utils|Project::Euler::Lib::Utils>.


=attr multi_nums

An array of positive integers that are used to filter out the number to sum.

This array is always kept sorted in order to optimize the solve function

=for :list
= Isa
PosIntArry
= Default
C<[3, 5]>

=cut

has 'multi_nums' => (
    is       => 'rw',
    isa      => PosIntArray,
    required => 1,
    default  => sub { return [3, 5] },  ## no critic 'ValuesAndExpressions::ProhibitMagicNumbers',
);
around 'multi_nums' => sub {
    my ($func, $self, $args) = @_;

    if  (ref $args) {
        $self->$func( [sort {$a <=> $b} @$args] );
    }
    else {
        $self->$func();
    }
};



=head1 SETUP

=head2 Problem Number

    001

=cut

sub _build_problem_number {
    #  Must be an int > 0
    return 1;
}


=head2 Problem Name

    Sum filtered list

=cut

sub _build_problem_name {
    #  Must be a string whose length is between 10 and 80
    return q{Sum filtered range};
}


=head2 Problem Date

    2001-10-05

=cut

sub _build_problem_date {
    return q{05 October 2001};
}


=head2 Problem Desc

If we list all the natural numbers below 10 that are multiples of 3 or 5, we
get 3, 5, 6 and 9. The sum of these multiples is 23.

Find the sum of all the multiples of 3 or 5 below 1000.

=cut

sub _build_problem_desc {
    return <<'__END_DESC';
If we list all the natural numbers below 10 that are multiples of 3 or 5, we get 3, 5, 6 and 9. The sum of these multiples is 23.

Find the sum of all the multiples of 3 or 5 below 1000.
__END_DESC
}


=head2 Default Input

=for :list
= The maximum value
C<1,000>

=cut

sub _build_default_input {
    return 1_000;
}


=head2 Default Answer

    233,168

=cut

sub _build_default_answer {
    return 233_168;
}


=head2 Has Input?

    Yes

=cut

has '+has_input' => (default => 1);


=head2 Help Message

You can change C<< multi_nums >> to alter the way the program will function.  If you
are providing custom_input, don't forget to specify the wanted_answer if you
know it!

=cut

sub _build_help_message {
    return <<'__END_HELP';
You can change multi_nums to alter the way the program will function.  If you
are providing custom_input, don't forget to specify the wanted_answer if you
know it!
__END_HELP
}



=head1 INTERNAL FUNCTIONS

=head2 Validate Input

The restrictions on custom_input

    A positve integer

=cut

sub _check_input {
      my ( $self, $input, ) = @_;

      if ($input !~ /\D/xms  or  $input < 1) {
          croak sprintf q{Your input, '%s', must be all digits and >= 1}, $input;
      }
}



=head2 Solving the problem

Loop from the first multi_num up to the max_number and filter all numbers that
are not multiples of one/all of the multi_nums.  Then use the List::More util
'sum' to return the sum of the filtered numbers.  If nothing was found return 0
rather than undef.

=cut

sub _solve_problem {
    my ($self, $max) = @_;

    #  If the user didn't give us a max, then use the default_input
    $max //= $self->default_input;

    #  Tell the checker object the numbers to filter on
    my $multi_nums = $self->multi_nums;

    #  Sum the filtered numbers.  Since we know the list is sorted, we start at
    #  the first multi_num since anything less than that cannot possible return
    #  true.
    return  sum(grep {multiple_check( $_, $multi_nums )}
                     $self->multi_nums->[0] .. ($max-1))  //  0;
}


=head1 SEE ALSO
List::Util
Project::Euler::Lib::Utils

=cut

__PACKAGE__->meta->make_immutable;
1;  # End of Project::Euler::Problem::P001
