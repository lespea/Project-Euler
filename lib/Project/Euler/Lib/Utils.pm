use strict;
use warnings;
use utf8;

package Project::Euler::Lib::Utils;

use Modern::Perl;
use Carp;

use List::MoreUtils qw/ any  all /;
use Const::Fast;

#  We won't build the cache if the user wants a fib number grater than this
const  my $MAX_FIB_CACHE_REQUEST => 100_000;

#  Export our functions with tags
use Exporter::Easy (
    TAGS => [
        fibs => [qw/ fib_generator  n_fibs /],
        list => [qw/ multiple_check /],
        all  => [qw/ :fibs  :list /],
    ],
    #OK => [qw( some other stuff )],
);


#  Initial array of fib #s
my @fibs = (1, 1);


#ABSTRACT: Collection of helper utilities for project euler problems


=encoding utf8

=head1 SYNOPSIS

    use Project::Euler::Lib::Utils qw/ :all /;


=head1 EXPORTS

=head2 :fibs

=for :list
* fib_generator
* n_fibs

=head2 :list

=for :list
* filter_ranges

=head2 :all

=for :list
* :fibs
* :list

=cut


=func fib_generator

This returns a clojure that returns the next successive fib number with each call

=head3 Example

    my $fib = fib_generator;

    #  Manually create the first 4 fibs
    my @fibs;
    push @fibs, $fib->()  for  1..4;

=cut

sub fib_generator {
    my ($fib_first, $fib_second) = (0, 1);
    return sub {
        #  Swap the 2 numbers
        ($fib_first, $fib_second) = ($fib_second, $fib_first + $fib_second);

        #  And return the newly generated first one
        return $fib_first;
    };
}



=func n_fibs

The returns either the first 'n' fibs or the nth fib if called in scalar
context.  If only the nth fib is used, then no memory is used to store the
previous fibs and it should run very fast.  For now this does some very
primitive caching but will have to be improved in the future.

This also does not currently use Math::BigInt so if a large # is requested it
may not be 100% accurate.  This will be fixed once I decide upon a caching
solution.

=head3 Parameters

=for :list
1. Fib number (or list up to a number) that you would like returned.

=head3 Example

    #  Get the first 4 fib numbers
    my @fibs = n_fibs( 4 );

    #  Just get the last one
    my $fourth_fib = n_fibs( 4 );

    $fibs[-1] == $fourth_fib;

=cut

sub n_fibs {
    my ($num) = @_;

    #  Turn $num into a string signifying undef to prepare for the error message.
    $num //= 'UNDEFINED';

    #  If a number > 0 was not passed, then confess with an error
    confess "You must provide an integer > 0 to n_fibs.  You provided: '$num'"
        if  $num !~ /\A\d+\z/xms  or  $num <= 0;

    #  If we've already calculated the fib the user wants, then simply return
    #  that value now

    if  (scalar @fibs >= $num) {
        #  User is using 1-base not 0-base
        $num--;

        #  If the user wants an array, then take a slice, otherwise just grab that element.
        return  wantarray  ?  @fibs[0..$num]  :  $fibs[$num];
    }

    #  If not, then we'll take a different course of action depending on whether
    #  the user wants an array or not.  I don't just fill out the cache because
    #  if the user wanted a huge value, then that would be impractical.  I could
    #  do some logic around the # requested but I'm going to postpone that for
    #  now until I have an all-around bettter caching solution.
    elsif  (wantarray  or  $num <= $MAX_FIB_CACHE_REQUEST) {
        #  Calculate how many values we already have
        $num -= @fibs;

        #  Increase the size of the array until it's the size we want.
        push @fibs, $fibs[-2] + $fibs[-1]  while  $num--;  ## no critic 'ValuesAndExpressions::ProhibitMagicNumbers'

        return  wantarray  ?  @fibs  :  $fibs[-1];
    }

    #  Otherwise we'll just start with the last 2 known fibs and go from there
    #  till we get to the # we want.
    else {
        #  User is using 1-base not 0-base
        $num--;

        #  Calculate the fibs until we find the one we want.
        my ($fib_first, $fib_second) = @fibs[-2, -1];  ## no critic 'ValuesAndExpressions::ProhibitMagicNumbers'
        ($fib_first, $fib_second) = ($fib_second, $fib_first+$fib_second)  while  $num--;

        return $fib_first;
    }
}



=func multiple_check

Check to see if a number is evenly divisible by one or all of a range of numbers.

=head3 Parameters

=for :list
1. Number to check divisibility on             (I<must be greater than 0>)
2. Range of numbers to check for divisibility  (I<all must be grater than 0>)
3. Boolean to check all range numbers          (B<optional>)

=head3 Example

    my $is_divisible     = multiple_check(15, [2, 3, 5], 0);
    my $is_divisible2    = multiple_check(15, [2, 3, 5]);
    my $is_not_divisible = multiple_check(10, [3, 6, 7]);

    my $is_all_divisible     = multiple_check(30, [2, 3, 5], 1);
    my $is_not_all_divisible = multiple_check(15, [2, 3, 5], 1);

    my @div_by = multiple_check(15, [2, 3, 5]);
    @div_by ~~ (3, 5) == 1;


    my $num = 3;
    my $is_prime = !multiple_check($num, [2..sqrt($num)]);

=cut

sub multiple_check {
    my ($num, $ranges, $all) = @_;
    #  Turn $num into a string signifying undef to prepare for the error message.
    $num //= 'UNDEFINED';

    #  If a number > 0 was not passed as the num range, then confess with an error
    confess "You must provide an integer > 0 to filter_ranges for the first arg.  You provided: '$num'"
        if  $num !~ /\D/xms  or  $num <= 0;

    confess 'You must provide an array ref of integers as the second arg to filter_ranges!'
        if       (!defined $ranges)         #  Makes sure ranges is defined
            or   ref $ranges ne 'ARRAY'     #  Makes sure ranges is an array_ref
            or   ((grep  {
                          (!$_)             #  Ensure none of the values are either undef or 0
                      or  $_ =~ /\D/xms     #    or ontains something that isn't a digit
                    }
                    @$ranges) > 0);


    #  We only want need to check the values that are > than the number to
    #  check, since a number can not be divisible by another number that is
    #  greater than itself.
    my @ranges = grep {$_ <= $num} @$ranges;

    #  If the user wanted to check all of the numbers, then return "false" if
    #  any number got filtered out
    return 0  if  ($all  and  scalar @ranges != scalar @$ranges);

    #  If there are no (remaining) numbers to filter on, then we'll return
    #  failure
    return 0  unless  scalar @ranges;


    #  If the user wants the values that matched (and isn't filtering on all of
    #  them) then we need to keep track of which ones matched so we have to use
    #  a slower native-perl version
    if  (wantarray  and  (!$all)) {
        my @return_range;
        for  my $mult  (@ranges) {
            push @return_range, $mult  if  $num % $mult == 0;
        }
        return @return_range;
    }


    #  Otherwise we can use List::MoreUtils's fast XS utils to do the checking
    #  for us
    my $status  =  $all  ?  all {($num % $_) == 0} @ranges
                         :  any {($num % $_) == 0} @ranges
                         ;


    #  Take the appropriate action depending on the context we're in
    if  (wantarray) {
        return  $status  ?  @ranges  :  ();
    }
    else {
        return  $status  ?  1  :  0;
    }
}



1; # End of String::Palindrome
