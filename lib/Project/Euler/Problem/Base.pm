package Project::Euler::Problem::Base;

use Modern::Perl;
use Moose::Role;
use Moose::Util::TypeConstraints;

use Carp;
use DateTime;
use DateTime::Format::Natural;
use Readonly;

Readonly::Scalar my $BASE_URL => q{http://projecteuler.net/index.php?section=problems&id=};


=head1 NAME

Project::Euler::Problem::Base - Abstract class that the problems will extend from

=head1 VERSION

Version 0.01

=cut

our $VERSION = '0.01';


=head1 SYNOPSIS

To ensure that each problem class performs a minimum set of functions, this
class will define the basic subroutines and variables that every object must
implement.  This will make wrapping a gui around them much simpler in the
future while also eliminating a lot of confustion that could arise from having
different method names/conventions

    with Project::Euler::Problem::Base;


=head1 SUBTYPES

Create the subtypes that we will use to validate the arguments defined by the
extending classes

    Base::link      = _ \A \Qhttp://projecteuler.net/index.php?section=problems&id=\E \d+ \z _xms
    Base::prob_num  = int > 0
    Base::prob_name = str -> 10 < len < 80

We also tell Moose how to coerce a given string into a DateTime object

=cut

subtype 'Base::link'
    => as 'Str'
    => message { "$_ is not a a valid link" }
    => where {
        $_ =~ m{ \A \Q$BASE_URL\E \d+ \z }xms;
    };

subtype 'Base::prob_num'
    => as 'Int'
    => message { "$_ is not an integer greater than 0" }
    => where {
        $_ > 0;
    };

subtype 'Base::prob_name'
    => as 'Str'
    => message { "$_ must be a a string between 10 and 80 characters long" }
    => where {
        length $_ > 10  and  length $_ < 80;
    };


my $en_parser = DateTime::Format::Natural->new(
    lang      => 'en',
    time_zone => 'UTC',
);
class_type 'DateTime';
coerce 'DateTime'
    => from 'Str'
    => via { $en_parser->parse_datetime($_) };



=head1 VARIABLES

These are the base variables that every module should have.  Because each
extending module will be changing these values, we will force them to create
functions which will set the attributes.  We also declare the init_arg as undef
so nobody creating an instance of the problem can over-write the values.

    problem_number ( prob_num  )  # Problem number on projecteuler.net
    problem_name   ( prob_name )  # Short name given by the module author
    problem_date   ( DateTime  )  # Date posted on projecteuler.net
    problem_desc   ( str       )  # Description posted on projecteuler.net
    problem_link   ( URL       )  # URL to the problem's homepage

    default_input  ( str       )  # Default input posted on projecteuler.net
    default_answer ( str       )  # Default answer to the default input

    has_input      ( boolean   )  # Some problems might not have so this lets us disable it
    use_defaults   ( boolean   )  # Use the default inputs

    custom_input   ( str       )  # User provided input to the problem

    solve_status   ( boolean   )  # True means it was valid
    solve_answer   ( str       )  # Last answer provided

=cut

has 'problem_number' => (
    is         => 'ro',
    isa        => 'Base::prob_num',
    required   => 1,
    lazy_build => 1,
    init_arg   => undef,
);
requires '_build_problem_number';

has 'problem_name' => (
    is         => 'ro',
    isa        => 'Base::prob_name',
    required   => 1,
    lazy_build => 1,
    init_arg   => undef,
);
requires '_build_problem_name';

has 'problem_date' => (
    is         => 'ro',
    isa        => 'DateTime',
    coerce     => 1,
    required   => 1,
    lazy_build => 1,
    init_arg   => undef,
);
requires '_build_problem_date';

has 'problem_desc' => (
    is         => 'ro',
    isa        => 'Str',
    required   => 1,
    lazy_build => 1,
    init_arg   => undef,
);
requires '_build_problem_desc';

has 'problem_link_base' => (
    is         => 'ro',
    isa        => 'Str',
    required   => 1,
    lazy       => 1,
    init_arg   => undef,
    default    => $BASE_URL,
);

has 'problem_link' => (
    is         => 'ro',
    isa        => 'Base::link',
    required   => 1,
    lazy_build => 1,
    init_arg   => undef,
);

has 'default_input' => (
    is         => 'ro',
    isa        => 'Str',
    required   => 1,
    lazy_build => 1,
    init_arg   => undef,
);
requires '_build_default_input';

has 'default_answer' => (
    is         => 'ro',
    isa        => 'Str',
    required   => 1,
    lazy_build => 1,
    init_arg   => undef,
);
requires '_build_default_answer';


has 'has_input' => (
    is       => 'ro',
    isa      => 'Bool',
    required => 1,
    default  => 1,
    init_arg => undef,
);

has 'use_defaults' => (
    is       => 'rw',
    isa      => 'Bool',
    required => 1,
    default  => 1,
);


has 'help_message' => (
    is         => 'ro',
    isa        => 'Str',
    required   => 1,
    lazy_build => 1,
    init_arg   => undef,
);
requires '_build_help_message';


has 'custom_input'  => (
    is         => 'rw',
    isa        => 'Str',
    required   => 0,
    trigger    => sub {return sub { $_->[0]->_check_input() }},
);


has 'solve_status'  => (
    is         => 'ro',
    isa        => 'Maybe[Bool]',
    writer     => '_set_solved_status',
    required   => 0,
);

has 'solve_answer'  => (
    is         => 'ro',
    isa        => 'Maybe[Str]',
    writer     => '_set_solved_answer',
    required   => 0,
);




=head1 FUNCTIONS

    _check_input
    _solve_problem

=cut

requires '_check_input';
requires '_solve_problem';



=head1 PROVIDED FUNCTIONS

=head2 solve

This is the function that should be called to solve the problem.  Depending on
the object attributes that are set, it uses either the default or provided
inputs if they are required and returns the answer as a string

    my $problem_1  = Project::Euler::Problem::P001->new();
    my $def_answer = $problem_1->solve;

    $problem_1->custom_input => (42);
    $problem_1->use_defaults => (0);
    my $custom_answer = $problem_1->solve;

=cut

sub _build_problem_link {
    my ($self) = @_;
    return $BASE_URL . $self->problem_number;
}



sub solve {
    my ($self) = @_;
    my $answer;

    if ( $self->has_input ) {
        if ( $self->use_defaults ) {
            $answer = $self->_solve_problem( $self->default_input );
        }
        else {
            my $custom_arg = $self->custom_input;

            #  Make sure the user didn't try to use a cutsom input string to
            #  solve the problem if it hasn't yet been defined!
            if  (!defined $custom_arg) {
                croak q{You tried to use custom inputs to solve the problem but it has not been set yet}
            }
            else {
                $answer = $self->_solve_problem( $custom_arg );
            }
        }
    }
    else {
        $answer = $self->_solve_problem( );
    }

    my $correct =  $self->use_defaults  ?  $answer eq $self->default_answer  :  undef;

    $self->_set_solved_answer($answer);
    $self->_set_solved_status($correct);

    return wantarray  ?  ($correct, $answer, $self->default_answer // q{})  :  [$correct, $answer, $self->default_answer // q{}];
}




=head1 AUTHOR

Adam Lesperance, C<< <lespea at gmail.com> >>

=head1 BUGS

Please report any bugs or feature requests to C<bug-project-euler at rt.cpan.org>, or through
the web interface at L<http://rt.cpan.org/NoAuth/ReportBug.html?Queue=Project-Euler>.  I will be notified, and then you'll
automatically be notified of progress on your bug as I make changes.




=head1 SUPPORT

You can find documentation for this module with the perldoc command.

    perldoc Project::Euler::Base


=head1 ACKNOWLEDGEMENTS


=head1 COPYRIGHT & LICENSE

Copyright 2009 Adam Lesperance.

This program is free software; you can redistribute it and/or modify it
under the terms of either: the GNU General Public License as published
by the Free Software Foundation; or the Artistic License.

See http://dev.perl.org/licenses/ for more information.


=cut

no Moose::Role;
1; # End of Project::Euler
