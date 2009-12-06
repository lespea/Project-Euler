package Project::Euler::Lib::MultipleCheck;

use Modern::Perl;
use Moose;
use Moose::Util::TypeConstraints;

use Carp;
use Readonly;

with Project::Euler::Lib::Common;


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

    multi_nums (Array[PosInts]) # Numbers to modulo with
    check_all  (Boolean)        # Ensure all numbers are divisible instead of just one

=cut

has 'multi_nums' => (
    is          => 'rw',
    isa         => 'Array[Lib::PosInt]',
    required    => 1,
    lazy_build  => 1,
);

has 'check_all' => (
    is          => 'rw',
    isa         => 'Boolean',
    required    => 1,
    default     => 0,
);



=head1 FUNCTIONS

    _check_input
    _solve_problem

=cut

requires '_check_input';
requires '_solve_problem';



#  Internal function
sub _build_problem_link {
    my ($self) = @_;
    return $BASE_URL . $self->problem_number;
}



=head1 PROVIDED FUNCTIONS

=head2 solve

This is the function that should be called to solve the problem.  Depending on
the object attributes that are set, it uses either the default or provided
inputs if they are required and returns the answer as a string

    my $problem_1  = Project::Euler::Problem::P001->new();
    my $def_answer = $problem_1->solve;

    $problem_1->custom_input  => (42);
    $problem_1->custom_answer => (42);
    $problem_1->use_defaults  => (21);
    my $custom_answer = $problem_1->solve;

=cut

sub solve {
    my ($self) = @_;
    my $answer;

    #  There may be parameters to pass so get determine what they are and pass
    #  them
    if ( $self->has_input ) {
        #  Use the module_provided defaults (ie pass nothing)
        if ( $self->use_defaults ) {
            $answer = $self->_solve_problem;
        }
        #  Pass the user input to the subroutine
        elsif (defined $self->custom_input) {
            $answer = $self->_solve_problem( $self->custom_input );
        }
        #  The user tried to use a cutsom input string to
        #  solve the problem but hasn't defined it yet!
        else {
            croak q{You tried to use custom inputs to solve the problem but it has not been set yet}
        }
    }

    #  There are no paramaters to pass!
    else {
        $answer = $self->_solve_problem;
    }


    #  Determine if the given answer was correct :: use 0 rather than undef
    my $wanted  =  $self->use_defaults  ?  $self->default_answer  :  $self->custom_answer;

    $answer //= q{};  $wanted //= q{};

    my $status  =  $answer eq $wanted;

    #  Save the answer, wanted, and status
    $self->_set_solved_answer($answer);
    $self->_set_solved_wanted($wanted);
    $self->_set_solved_status($status);

    #  Return either the status, answer, and wanted or, if the user just
    #  expects a scalar, the found answer
    return wantarray  ?  ($status, $answer, $wanted)  :  $answer;
}




=head2 status

This function simply returns a nice, readable status message that tells you the
outcome of the last run of the module.  This is way the array won't have to be
parsed every time to determine the various states that are saved.

    my $problem_1  = Project::Euler::Problem::P001->new();
    $problem_1->solve;
    my $message = $problem_1->last_run_message;

=cut

sub status {
    my ($self) = @_;
    my ($answer, $wanted, $status) =
        @{$self}{qw/ solved_answer  solved_wanted  solved_status /};

    if (!defined $status) {
        return q{It appears that the problem has yet to be solved once.};
    }
    else {
        return printf(q{The last run was%s succesfull!  The answer expected was '%s' %s the answer returned was '%s'},
            $status ? q{} : 'not', $wanted, $status ? 'and' : 'but', $answer
        );
    }
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
