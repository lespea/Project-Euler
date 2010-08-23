use strict;
use warnings;
package Project::Euler::Problem::P002;

use Modern::Perl;
use namespace::autoclean;

use Moose;
use Carp;

with 'Project::Euler::Problem::Base';

use Project::Euler::Lib::Types  qw/ PosInt  PosIntArray /;
use Project::Euler::Lib::Utils  qw/ multiple_check  fib_generator /;

use List::Util  qw/ sum /;


#ABSTRACT: Solutions for problem 002 - Sum filtered fib numbers


=head1 HOMEPAGE

L<< http://projecteuler.net/index.php?section=problems&id=2 >>


=head1 SYNOPSIS

    use Project::Euler::Problem::P002;
    my $p2 = Project::Euler::Problem::P002->new;

    my $default_answer = $p2->solve;


=head1 DESCRIPTION

This module is used to solve problem #002

This is a simple problem which computes the fib numbers up to a certain maximum
and sums all of them that are even (or as implemented here, divisible by every
multi_nums)


=attr multi_nums

An array of positive numbers that are used to filter out the fib numbers

=for :list
= Isa
PosIntArray
= Default
C<[2]>

=cut

has 'multi_nums' => (
    is       => 'rw',
    isa      => PosIntArray,
    required => 1,
    default  => sub { return [2] },
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

    002

=cut

sub _build_problem_number {
    #  Must be an int > 0
    return 2;
}


=head2 Problem Name

    Sum filtered fib numbers

=cut

sub _build_problem_name {
    #  Must be a string whose length is between 10 and 80
    return q{Sum filtered fib numbers};
}


=head2 Problem Date

    2001-10-19

=cut

sub _build_problem_date {
    return q{19 October 2001};
}


=head2 Problem Desc

Each new term in the Fibonacci sequence is generated by adding the previous two
terms. By starting with 1 and 2, the first 10 terms will be:

1, 2, 3, 5, 8, 13, 21, 34, 55, 89, ...

Find the sum of all the even-valued terms in the sequence which do not exceed
four million.

=cut

sub _build_problem_desc {
    return <<'__END_DESC';
Each new term in the Fibonacci sequence is generated by adding the previous two terms. By starting with 1 and 2, the first 10 terms will be:

1, 2, 3, 5, 8, 13, 21, 34, 55, 89, ...

Find the sum of all the even-valued terms in the sequence which do not exceed four million.
__END_DESC
}


=head2 Default Input

=for :list
= Max number to go up to
C<4,000,000>

=cut

sub _build_default_input {
    return 4_000_000;
}


=head2 Default Answer

    4,613,732

=cut

sub _build_default_answer {
    return 4_613_732;
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

    A positive integer

=cut

sub _check_input {
      my ( $self, $input, ) = @_;

      if ($input !~ /\D/ or $input < 1) {
          croak sprintf(q{Your input, '%s', must be all digits and >= 1}, $input);
      }
}



=head2 Solving the problem

Generate all of the fib numbers up to $max, filter them by the multi_nums
attribute, and find the sum

=cut

sub _solve_problem {
    my ($self, $max) = @_;

    #  If the user didn't give us a max, then use the default_input
    $max //= $self->default_input;

    #  Pull the multi_nums out of the object
    my $multi_nums = $self->multi_nums;

    #  Initialize the sum and fib tracker
    my $sum = 0;
    my @fibs;

    #  Create a new Fibonacci generator
    my $fib_gen = fib_generator;

    while ((my $fib = $fib_gen->()) < $max) {
        if  (multiple_check($fib, $multi_nums)) {
            $sum += $fib;
            push @fibs, $fib;
        }
    }

    $self->_set_more_info(sprintf('The fibs were %s', join q{, }, @fibs));
    return $sum;
}



=head1 ACKNOWLEDGEMENTS

=for :list
* L<< List::Util >>
* L<< Project::Euler::Lib::Utils >>

=cut

__PACKAGE__->meta->make_immutable;
1; # End of Project::Euler::Problem::P002
