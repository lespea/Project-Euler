use strict;
use warnings;
package Project::Euler;

use Modern::Perl;

#ABSTRACT: Solutions for L<< www.projecteuler.net >>


=head1 SYNOPSIS

    use Project::Euler::Problem::P001;
    my $problem1 = Project::Euler::Problem::P001->new;

    $problem1->solve;
    print $problem1->status;


=head1 DESCRIPTION

This is the base class which will eventually be responsible for displaying the
interface to interact with the solutions implemented so far.

For now, you will have to manually import the problem_solutions and solve them manually.


=head1 LIBRARIES

_hese libraries are used by the problem solutions:

=for :list
1. L<< Project::Euler::Lib::MultipleCheck >>
2. L<< Project::Euler::Lib::Types >>


=head1 PROBLEMS

These problems are fully implemented so far (extending the base class L<< Project::Euler::Problem::Base >>)

=for :list
1. L<< Project::Euler::Problem::P001 >>
2. L<< Project::Euler::Problem::P002 >>


=cut



1; # End of Project::Euler
