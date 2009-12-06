package Project::Euler::Lib::Common;

use Modern::Perl;

use Moose::Role;
use Moose::Util::TypeConstraints;


=head1 NAME

Project::Euler::Lib::Common

=head1 VERSION

Version v0.1.0

=cut

use version 0.77; our $VERSION = qv("v0.1.0");


=head1 SYNOPSIS

Base class that will only hold the subtypes for all the libraries

    with Project::Euler::Lib::Common;


=head1 SUBTYPES

Create the subtypes that we will use by the other libraries

    Lib::PosInt = int > 0

=cut

subtype 'Lib::PosInt'
    => as 'Int'
    => message { sprintf('%s is not greater than 0', $_ // 'undefined') }
    => where {
        $_ > 0;
    }
;


=head1 AUTHOR

Adam Lesperance, C<< <lespea at gmail.com> >>

=head1 BUGS

Please report any bugs or feature requests to C<bug-project-euler at rt.cpan.org>, or through
the web interface at L<http://rt.cpan.org/NoAuth/ReportBug.html?Queue=Project-Euler>.  I will be notified, and then you'll
automatically be notified of progress on your bug as I make changes.




=head1 SUPPORT

You can find documentation for this module with the perldoc command.

    perldoc Project::Euler::Lib::Common


=head1 ACKNOWLEDGEMENTS


=head1 COPYRIGHT & LICENSE

Copyright 2009 Adam Lesperance.

This program is free software; you can redistribute it and/or modify it
under the terms of either: the GNU General Public License as published
by the Free Software Foundation; or the Artistic License.

See http://dev.perl.org/licenses/ for more information.


=cut

no Moose::Role;
1; # End of Project::Euler::Lib::Common
