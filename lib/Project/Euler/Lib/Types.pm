use strict;
use warnings;
package Project::Euler::Lib::Types;

use Modern::Perl;
use namespace::autoclean;

#ABSTRACT: Type definitions for L<< Project::Euler >>


#  Declare our types
use MooseX::Types
    -declare => [qw/
        ProblemLink     ProblemName
        PosInt          PosIntArray
        NegInt          NegIntArray
        MyDateTime
/];


#  Import builtin types
use MooseX::Types::Moose qw/ Str  Int  ArrayRef /;



=head1 SYNOPSIS

    use Project::Euler::Lib::Types  qw/ ProblemLink  PosInt /;


=head1 DESCRIPTION

(Most) all of the types that our modules use are defined here so that they can
be reused and tested.  This also helps prevent all of the namespace pollution
from the global declarations.


=head1 SUBTYPES

Create the subtypes that we will use to validate the arguments defined by the
extending classes.

=head2 ProblemLink

A url pointing to a problem definition on L<< http://projecteuler.net >>.

=head3 Definition

    as Str,
    message { sprintf(q{'%s' is not a valid link}, $_ // '#UNDEFINED#') },
    where { $_ =~ m{
                \A
                \Qhttp://projecteuler.net/index.php?section=problems&id=\E
                \d+
                \z
            }xms
    };

=cut

subtype ProblemLink,
    as Str,
    message { sprintf(q{'%s' is not a valid link}, $_ // '#UNDEFINED#') },
    where { $_ =~ m{
                \A
                \Qhttp://projecteuler.net/index.php?section=problems&id=\E
                \d+
                \z
            }xms;
    };



=head2 ProblemName

In an effort to limit text runoff, the problem name is limited to 80
characters.  Similarly, the length must also be greater than 10 to ensure it is
something usefull.

=head3 Definition

    as Str,
    message { sprintf(q{'%s' must be a string between 10 and 80 characters long}, $_ // '#UNDEFINED#') },
    where {
        length $_ > 10  and  length $_ < 80;
    };

=cut

subtype ProblemName,
    as Str,
    message { sprintf(q{'%s' must be a string between 10 and 80 characters long}, $_ // '#UNDEFINED#') },
    where {
        length $_ > 10  and  length $_ < 80;
    };



=head2 PosInt

An integer greater than 0.

=head3 Definition

    as Int,
    message { sprintf(q{'%s' is not greater than 0}, $_ // '#UNDEFINED#') },
    where {
        $_ > 0
    }

=head2 PosIntArray

An array of PosInts.

=cut

subtype PosInt,
    as Int,
    message { sprintf(q{'%s' is not greater than 0}, $_ // '#UNDEFINED#') },
    where {
        $_ > 0;
    };
subtype PosIntArray, as ArrayRef[PosInt];



=head2 NegInt

An integer less than 0.

=head3 Definition

    as Int,
    message { sprintf(q{'%s' is not less than 0}, $_ // '#UNDEFINED#') },
    where {
        $_ < 0
    }

=head2 NegIntArray

An array of NegInts.

=cut

subtype NegInt,
    as Int,
    message { sprintf(q{'%s' is not less than 0}, $_ // '#UNDEFINED#') },
    where {
        $_ < 0;
    };
subtype NegIntArray, as ArrayRef[NegInt];



=head2 MyDateTime

A L<< DateTime:: >> object coerced using L<< DateTime::Format::DateParse >>

=head3 Definition

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




=head1 ACKNOWLEDGEMENTS

=for :list
* L<< MooseX::Types >>

=cut

1; # End of Project::Euler::Lib::Types
