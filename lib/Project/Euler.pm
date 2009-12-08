package Project::Euler;

use Modern::Perl;
use Carp;
use Try::Tiny;

use Exporter::Easy (
    OK => qw/ get_problem    get_all_problems
              solve_problem  solve_all_problems
          /;
);


use constant PROBLEM_PATH => 'lib/Project/Euler/Problem/';
use constant PROBLEM_BASE => 'Project::Euler::Problem::P';


my @modules;
opendir (my $dir, PROBLEM_PATH);
while (( my $filename = readdir($dir) )) {
    push @modules, $1  if  $filename =~ / \A p (\d+) \.pm \z /xmsi;
}

my %module_obj;
MODULE:
for  my $module  (@modules) {
    my $mod_name = sprintf('%s%03d', PROBLEM_BASE, $module);
    my $problem;

    try {
        eval "use $mod_name";
    }
    catch {
        carp "Error loading $mod_name";
        next MODULE;
    }

    try {
        $problem = $mod_name->new();
    }
    catch {
        carp "Error creating an instance of $mod_name";
        next MODULE;
    }

    my $mod_str = sprintf('%03d => %s', $problem->problem_number, $problem->problem_name);

    $module_obj{$mod_str} = $problem;
}


=head1 NAME

Project::Euler - Solutions for L<< http://projecteuler.net >>

=head1 VERSION

Version 0.1.4

=cut

use version 0.77; our $VERSION = qv("v0.1.4");


=head1 SYNOPSIS

This is the base class which will eventually be responsible for displaying the
interface to interact with the solutions implemented so far

=head1 EXPORT

    get_problem
    solve_problem

    get_all_problems
    solve_all_problems

=head1 FUNCTIONS

=head2 get_problem

=cut


=head2 get_all_problems

=cut


=head2 solve_problem

=cut


=head2 solve_all_problems

=cut


=head1 AUTHOR

Adam Lesperance, C<< <lespea at cpan.org> >>

=head1 BUGS

Please report any bugs or feature requests to C<bug-project-euler at rt.cpan.org>, or through
the web interface at L<http://rt.cpan.org/NoAuth/ReportBug.html?Queue=Project-Euler>.  I will be notified, and then you'll
automatically be notified of progress on your bug as I make changes.




=head1 SUPPORT

You can find documentation for this module with the perldoc command.

    perldoc Project::Euler


You can also look for information at:

=over 4

=item * RT: CPAN's request tracker

L<http://rt.cpan.org/NoAuth/Bugs.html?Dist=Project-Euler>

=item * AnnoCPAN: Annotated CPAN documentation

L<http://annocpan.org/dist/Project-Euler>

=item * CPAN Ratings

L<http://cpanratings.perl.org/d/Project-Euler>

=item * Search CPAN

L<http://search.cpan.org/dist/Project-Euler/>

=back


=head1 ACKNOWLEDGEMENTS


=head1 COPYRIGHT & LICENSE

Copyright 2009 Adam Lesperance.

This program is free software; you can redistribute it and/or modify it
under the terms of either: the GNU General Public License as published
by the Free Software Foundation; or the Artistic License.

See http://dev.perl.org/licenses/ for more information.


=cut

1; # End of Project::Euler
