package Project::Euler::Lib::Types;

use Modern::Perl;


#  Declare our types
use MooseX::Types
    -declare => [qw/
        PosInt      PosIntArray
        NegInt      NegIntArray
        MyDateTime
/];


#  Import builtin types
use MooseX::Types::Moose qw/ Str  Int  ArrayRef /;

=head1 NAME

Project::Euler::Lib::Types - Type definitions for L<< Project::Euler >>

=head1 VERSION

Version v0.1.1

=cut

use version 0.77; our $VERSION = qv("v0.1.1");


=head1 SYNOPSIS

    use Project::Euler::Lib::Types  qw/ (types to import) /;

=head1 DESCRIPTION

(Most) all of the types that our modules use are defined here so that they can
be reused and tested.  This also helps prevent all of the namespace pollution
from the global declarations.


=head1 SUBTYPES

=head2 PosInt

An integer greater than 0

    as Int,
    where {
        $_ > 0
    }

=head3 PosIntArray

An array of PosInts

=cut

subtype PosInt,
    as Int,
    message { sprintf(q{'%s' is not greater than 0}, $_ // '#UNDEFINED#') },
    where {
        $_ > 0;
    };
subtype PosIntArray, as ArrayRef[PosInt];


=head2 NegInt

An integer less than 0

    as Int,
    where {
        $_ < 0
    }

=head3 NegIntArray

An array of NegInts

=cut

subtype NegInt,
    as Int,
    message { sprintf(q{'%s' is not less than 0}, $_ // '#UNDEFINED#') },
    where {
        $_ < 0;
    };
subtype NegIntArray, as ArrayRef[NegInt];


=head2 MyDateTime

A L<< DateTime >> object parsed using L<< DateTime::Format::DateParse >>

    class_type MyDateTime, { class => 'DateTime' };
    coerce MyDateTime,
        from Str,
        via {
            DateTime::Format::DateParse->parse_datetime( $_ );
        };

=cut

use DateTime;
use DateTime::Format::DateParse;

class_type MyDateTime, { class => 'DateTime' };
coerce MyDateTime,
    from Str,
    via {
        DateTime::Format::DateParse->parse_datetime( $_ );
    };

=head1 AUTHOR

Adam Lesperance, C<< <lespea at cpan.org> >>

=head1 BUGS

Please report any bugs or feature requests to C<bug-project-euler at rt.cpan.org>, or through
the web interface at L<http://rt.cpan.org/NoAuth/ReportBug.html?Queue=Project-Euler>.  I will be notified, and then you'll
automatically be notified of progress on your bug as I make changes.


=head1 SUPPORT

You can find documentation for this module with the perldoc command.

    perldoc Project::Euler::Lib::Common


=head1 COPYRIGHT & LICENSE

Copyright 2009 Adam Lesperance.

This program is free software; you can redistribute it and/or modify it
under the terms of either: the GNU General Public License as published
by the Free Software Foundation; or the Artistic License.

See http://dev.perl.org/licenses/ for more information.


=cut

no Moose::Role;
1; # End of Project::Euler::Lib::Common
