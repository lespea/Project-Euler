use strict;
use warnings;
use utf8;

package Project::Euler;

use Modern::Perl;
use 5.010;  # So Dist::Zilla picks it up

#ABSTRACT: Solutions for Project Euler

=encoding utf8

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

These libraries are used by the problem solutions:

=for :list
1. L<Utils|Project::Euler::Lib::Utils>
2. L<Types|Project::Euler::Lib::Types>


=head1 PROBLEMS

These problems are fully implemented so far (extending the base class L<Project::Euler::Problem::Base|Project::Euler::Problem::Base>)

=for :list
1. L<Problem 1|Project::Euler::Problem::P001>
2. L<Problem 2|Project::Euler::Problem::P002>
2. L<Problem 3|Project::Euler::Problem::P003>
2. L<Problem 4|Project::Euler::Problem::P004>
2. L<Problem 5|Project::Euler::Problem::P005>


=cut



1; # End of Project::Euler
