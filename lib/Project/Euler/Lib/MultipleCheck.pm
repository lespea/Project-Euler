use strict;
use warnings;
package Project::Euler::Lib::MultipleCheck;

use Modern::Perl;
use namespace::autoclean;

use Moose;
use MooseX::Method::Signatures;

use List::MoreUtils qw/ any  all /;
use Project::Euler::Lib::Types qw/ PosInt  PosIntArray /;


#ABSTRACT: Determine if an integer is divisible by an array of numbers


=head1 SYNOPSIS

    use Project::Euler::Lib::MultipleCheck;
    my $multi_check = Project::Euler::Lib::MultipleCheck->new(
        multi_nums => [2, 3, 5],
        check_all  => 0,  # Default
    );

    my $is_divisible = $multi_check->check(15);


=head1 DESCRIPTION

It is often useful to determine if a number is divisible by a set of numbers.
A basic example is to determine if an integer is even by testing it against the
array C<< [2] >>.  A boolean is also used to determining if the number should
be divisible by all of the integers in the array or if any will suffice.

The array of integers is always sorted to maximize efficiency (lower numbers
have a better chance of matching over higher ones).



=attr multi_nums

The numbers to test against.

=head3 Definition

    is          => 'rw',
    isa         => PosIntArray,
    lazy_build  => 1,
    required    => 1,

=cut

has 'multi_nums' => (
    is          => 'rw',
    isa         => PosIntArray,
    lazy_build  => 1,
    required    => 1,
);


=attr check_all

The check number must be divisible by all numbers in the array.

=head3 Definition

    is          => 'rw',
    isa         => 'Bool',
    required    => 1,
    default     => 0,

=cut

has 'check_all' => (
    is          => 'rw',
    isa         => 'Bool',
    required    => 1,
    default     => 0,
);



=method check

Function that returns a Boolean if the given number passes the checks.

=head3 Paramaters

=for :list
= num
The number that will be checked for divisibility of the multi_nums attribute.

=head3 Example

    my $check = Project::Euler::Lib::MultipleCheck->new(
        multi_nums => [3, 5],
        check_all  => 0,
    );

    OK      $multi_check->check( 9);
    NOT OK  $multi_check->check(11);


    $multi_check->check_all(1);

    OK      $multi_check->check(15);
    NOT OK  $multi_check->check( 9);


    DIES    $multi_check->multi_nums([0, 1]);  # Multi_nums must all be positive
    DIES    $multi_check->multi_nums( 2, 9 );  # Multi nums must be an array ref

    DIES    $multi_check->check('two');        # Can't check a string!

=cut


method check (PosInt $num) {
    my $multi_nums = $self->multi_nums;
    return  $self->check_all  ?  all {($num % $_) == 0} @$multi_nums
                              :  any {($num % $_) == 0} @$multi_nums
}


1; # End of Project::Euler::Lib::MultipleCheck
