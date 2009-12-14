package Project::Euler::Problem::P005;

use Carp;
use Modern::Perl;
use Moose;

with 'Project::Euler::Problem::Base';
use Project::Euler::Lib::Types  qw/ /;  ### TEMPLATE ###


=head1 NAME

Project::Euler::Problem::P005 - Solutions for problem 005

=head1 VERSION

Version v0.1.0

=cut

use version 0.77; our $VERSION = qv("v0.1.0");

=head1 SYNOPSIS

L<< http://projecteuler.net/index.php?section=problems&id=5 >>

    use Project::Euler::Problem::P005;
    my $p5 = Project::Euler::Problem::P005->new;

    my $default_answer = $p5->solve;

=head1 DESCRIPTION

This module is used to solve problem #005

### TEMPLATE ###

=head1 Problem Attributes

### TEMPLATE ###

=cut


=head1 SETUP

=head2 Problem Number

    005

=cut

sub _build_problem_number {
    #  Must be an int > 0
    return 5;
}


=head2 Problem Name

    ### TEMPLATE ###

=cut

sub _build_problem_name {
    return q{};### TEMPLATE ###
}


=head2 Problem Date

    30 November 2001

=cut

sub _build_problem_date {
    return q{30 November 2001};
}


=head2 Problem Desc

2520 is the smallest number that can be divided by each of the numbers from 1 to 10 without any remainder.What is the smallest number that is evenly divisible by all of the numbers from 1 to 20?

=cut

sub _build_problem_desc {
    return <<'__END_DESC';

2520 is the smallest number that can be divided by each of the numbers from 1 to 10 without any remainder.What is the smallest number that is evenly divisible by all of the numbers from 1 to 20?

__END_DESC
}


=head2 Default Input

### TEMPLATE ###

=cut

sub _build_default_input {
    return ;### TEMPLATE ###
}


=head2 Default Answer

    232792560

=cut

sub _build_default_answer {
    return 232792560;
}


=head2 Has Input?

    ### TEMPLATE ###

=cut
### TEMPLATE ###
#has '+has_input' => (default => 0);


=head2 Help Message

### TEMPLATE ###

=cut

sub _build_help_message {

    return <<'__END_HELP';

### TEMPLATE ###

__END_HELP

}



=head1 INTERNAL FUNCTIONS

=head2 Validate Input

### TEMPLATE ###

=cut

sub _check_input {
### TEMPLATE ###
}



=head2 Solving the problem

### TEMPLATE ###

=cut

sub _solve_problem {
    my ($self, $input) = @_;

    $input //= $self->default_input;
    ### TEMPLATE ###
}


=head1 AUTHOR

Adam Lesperance, C<< <lespea at cpan.org> >>

=head1 BUGS

Please report any bugs or feature requests to C<bug-project-euler at rt.cpan.org>, or through
the web interface at L<http://rt.cpan.org/NoAuth/ReportBug.html?Queue=Project-Euler>.  I will be notified, and then you'll
automatically be notified of progress on your bug as I make changes.




=head1 SUPPORT

You can find documentation for this module with the perldoc command.

    perldoc Project::Euler::Problem::P005


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
1; # End of Project::Euler::Problem::P005
