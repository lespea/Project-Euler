use strict;
use warnings;
package Project::Euler::Problem::P004;

use Carp;
use Modern::Perl;
use Moose;

use String::Palindrome qw/ is_palindrome /;

with 'Project::Euler::Problem::Base';
use Project::Euler::Lib::Types  qw/ PosInt /;


=head1 NAME

Project::Euler::Problem::P004 - Solutions for problem 004

=head1 VERSION

Version v0.1.0

=cut

use version 0.77; our $VERSION = qv("v0.1.0");

=head1 SYNOPSIS

L<< http://projecteuler.net/index.php?section=problems&id=4 >>

    use Project::Euler::Problem::P004;
    my $p4 = Project::Euler::Problem::P004->new;

    my $default_answer = $p4->solve;

=head1 DESCRIPTION

This module is used to solve problem #004

Given the length of ints to iterate through, we will find the largest product
that produces a palindrome.


=head1 SETUP

=head2 Problem Number

    004

=cut

sub _build_problem_number {
    #  Must be an int > 0
    return 4;
}


=head2 Problem Name

    Largest palindrome from prods

=cut

sub _build_problem_name {
    return q{Largest palindrome from prods};
}


=head2 Problem Date

    16 November 2001

=cut

sub _build_problem_date {
    return q{16 November 2001};
}


=head2 Problem Desc

A palindromic number reads the same both ways. The largest palindrome made from
the product of two 2-digit numbers is 9009 = 91 & 99.  Find the largest
palindrome made from the product of two 3-digit numbers.

=cut

sub _build_problem_desc {
    return <<'__END_DESC';

A palindromic number reads the same both ways. The largest palindrome made from
the product of two 2-digit numbers is 9009 = 91 & 99. Find the largest
palindrome made from the product of two 3-digit numbers.

__END_DESC
}


=head2 Default Input

The number of digits the numbers should have

=cut

sub _build_default_input {
    return 3;
}


=head2 Default Answer

    906609

=cut

sub _build_default_answer {
    return 906609;
}


=head2 Has Input?

    Yes

=cut
#has '+has_input' => (default => 0);


=head2 Help Message

There is little to no customization for this problem, simply tell it what you
want the number of digits to be

=cut

sub _build_help_message {

    return <<'__END_HELP';

There is little to no customization for this problem, simply tell it what you
want the number of digits to be

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

First we will calculate the int that we will be using to loop on.  Then we will
iterate backwards from that number to the smallest int with that many numbers
(ie 999 down to 100).  The inner loop will always start with the current outer
loop so no duplicate products are tested.

If we ever iterate the outer loop down and that number squared is less than the
max number found, then we will stop since it is impossible for any larger
number to ever be generated.

=cut

sub _solve_problem {
    my ($self, $length) = @_;

    $length //= $self->default_input;

    my $max = 0;
    my $high = 10 ** $length - 1;
    my $low  = 10 ** ($length - 1);

    my @nums;

    OUTER:
    for  (my $i = $high;  $i >= $low;  $i--) {
        last OUTER  if  ($i ** 2) < $max;

        for  (my $j = $i;  $j >= $low;  $j--) {
            my $prod = $i * $j;
            if ($prod > $max  and  is_palindrome($prod)) {
                $max = $prod;
                @nums = ($i, $j);
            }
        }
    }

    $self->_set_more_info(sprintf('The numbers were %d and %d', $nums[0], $nums[1]));
    return $max;
}


__PACKAGE__->meta->make_immutable;
1; # End of Project::Euler::Problem::P004
