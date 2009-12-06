package Project::Euler::Lib::MultipleCheck;

use Modern::Perl;
use Moose;
use MooseX::Method::Signatures;

use Carp;
use Readonly;
use List::MoreUtils qw/ any all /;

with 'Project::Euler::Lib::Common';


=head1 NAME

Project::Euler::Lib::MultipleCheck

=head1 VERSION

Version v0.1.0

=cut

use version 0.77; our $VERSION = qv("v0.1.0");


=head1 SYNOPSIS

Module that is used to determine if a number is a multiple of any (or
optionally all) numbers in an array

    use Project::Euler::Lib::MultipleCheck;
    my $multi_check = Project::Euler::Lib::MultipleCheck->new(
        multi_nums => [2, 3, 5],
        check_all  => 0,  # could omit this if you wanted to
    );



=head1 VARIABLES

The variables that the library needs to solve the problem

    multi_nums (ArrayRef[PosInts]) # Numbers to modulo with
    check_all  (Boolean)        # Ensure all numbers are divisible instead of just one

=cut

has 'multi_nums' => (
    is          => 'rw',
    isa         => 'ArrayRef[Lib::PosInt]',
    required    => 1,
);

has 'check_all' => (
    is          => 'rw',
    isa         => 'Bool',
    required    => 1,
    default     => 0,
);



=head1 FUNCTIONS

=head2 check

Function that returns a Boolean if the given number passes the checks

    my $check = Project::Euler::Lib::MultipleCheck->new(
        multi_nums => [3, 5],
        check_all  => 0,
    );

    my $true  = $multi_check->check(9);
    my $false = $multi_check->check(11);

    $multi_check->check_all(1);
    my $true  = $multi_check->check(15);
    my $false = $multi_check->check(10);


    $dies = $multi_check->multi_nums([0, 1]);  # Multi_nums must all be positive
    $dies = $multi_check->multi_nums((2, 9));  # Multi nums must be an array ref

    $dies = $multi_check->check('test');  # Can't check a num

=cut


method check (Int $num where {$_ > 0}) {
    my $multi_nums = $self->multi_nums;
    return  $self->check_all  ?  all {($num % $_) == 0} @$multi_nums
                              :  any {($num % $_) == 0} @$multi_nums
}




=head1 AUTHOR

Adam Lesperance, C<< <lespea at gmail.com> >>

=head1 BUGS

Please report any bugs or feature requests to C<bug-project-euler at rt.cpan.org>, or through
the web interface at L<http://rt.cpan.org/NoAuth/ReportBug.html?Queue=Project-Euler>.  I will be notified, and then you'll
automatically be notified of progress on your bug as I make changes.




=head1 SUPPORT

You can find documentation for this module with the perldoc command.

    perldoc Project::Euler::Lib::MultipleCheck


=head1 ACKNOWLEDGEMENTS


=head1 COPYRIGHT & LICENSE

Copyright 2009 Adam Lesperance.

This program is free software; you can redistribute it and/or modify it
under the terms of either: the GNU General Public License as published
by the Free Software Foundation; or the Artistic License.

See http://dev.perl.org/licenses/ for more information.


=cut

no Moose;
1; # End of Project::Euler::Lib::MultipleCheck
