package Project::Euler::Problem::P;  ### TEMPLATE ###

use Carp;
use Modern::Perl;
use Moose;

with 'Project::Euler::Problem::Base';




=head1 NAME

Project::Euler::Problem::P - Solutions for problem  projecteuler.net  ### TEMPLATE ###

=head1 VERSION

Version v0.1.0

=cut

use version 0.77; our $VERSION = qv("v0.1.0");


=head1 SYNOPSIS

This module is used to solve problem # located on projecteuer.net  ### TEMPLATE ###

{Talk about the problem}  ### TEMPLATE ###

    use Project::Euler::Problem::P;  ### TEMPLATE ###


=head1 SETUP

=head2 Problem Number

    0 ### TEMPLATE ###

=cut

sub _build_problem_number {
    #  Must be an int > 0
    return 0;  ### TEMPLATE ###
}


=head2 Problem Name

    Template Name  ### TEMPLATE ###

=cut

sub _build_problem_name {
    #  Must be a string whose length is between 10 and 80
    return q{Template Name};  ### TEMPLATE ###
}


=head2 Problem Date

    2012-12-21  ### TEMPLATE ###

=cut

sub _build_problem_date {
    return q{2012-12-21};  ### TEMPLATE ###
}


=head2 Problem Desc

Template description that must be changed  ### TEMPLATE ###

=cut

sub _build_problem_desc {
    return <<'__END_DESC';  ### TEMPLATE ###
    This is just some text that will need to be
replaced eventually.  For now it serves it's purpose
__END_DESC
}


=head2 Default Input

    None obviously  ### TEMPLATE ###

=cut

sub _build_default_input {
    return q{};  ### TEMPLATE ###
}


=head2 Default Answer

    42  ### TEMPLATE ###

=cut

sub _build_default_answer {
    return '42';  ### TEMPLATE ###
}


=head2 Has Input?

    No  ### TEMPLATE ###

=cut

#has '+has_input' => (default => 0);  ### TEMPLATE ###


=head2 Help Message

None at this time  ### TEMPLATE ###

=cut

sub _build_help_message {
    return <<'__END_HELP';  ### TEMPLATE ###
Please override this message!
__END_HELP
}



=head1 FUNCTIONS

=head2 Validate Input (internal function)

The input must must be formatted like this:

    well not like template code!  ### TEMPLATE ###

=cut

sub _check_input {
      my ( $self, $input, $old_input ) = @_;  ### TEMPLATE ###

      if (q{Template_check} eq q{Change this}) {
          croak sprintf(q{Your input, '%s', didn't pass the quality checks}, $input);
      }
}



=head2 Solve the problem (internal function)

Put your logic in here please  ### TEMPLATE ###

=cut

sub _solve_problem {
    return 1;  ### TEMPLATE ###
}


=head1 AUTHOR

Adam Lesperance, C<< <lespea at cpan.org> >>

=head1 BUGS

Please report any bugs or feature requests to C<bug-project-euler at rt.cpan.org>, or through
the web interface at L<http://rt.cpan.org/NoAuth/ReportBug.html?Queue=Project-Euler>.  I will be notified, and then you'll
automatically be notified of progress on your bug as I make changes.




=head1 SUPPORT

You can find documentation for this module with the perldoc command.

    perldoc Project::Euler::Problem::P  ### TEMPLATE ###

=head1 ACKNOWLEDGEMENTS


=head1 COPYRIGHT & LICENSE

Copyright 2009 Adam Lesperance.

This program is free software; you can redistribute it and/or modify it
under the terms of either: the GNU General Public License as published
by the Free Software Foundation; or the Artistic License.

See http://dev.perl.org/licenses/ for more information.


=cut


#  Cleanup the Moose stuff
no Moose;
__PACKAGE__->meta->make_immutable;
1; # End of Project::Euler
