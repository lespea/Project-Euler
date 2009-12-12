#!perl -T

use strict;
use warnings;

use autodie;
use Test::Most;
use File::Find;
use File::Slurp;

use Readonly;

Readonly::Scalar  my $MAKEFILE     => 'Makefile.PL';
Readonly::Scalar  my $PROBLEM_PATH => 'lib/Project/';

my %required_for;

my $get_mod_info = qr{
    \A
    (?<type>
        (?:test_)?
        requires
    )
    \s+
    '
    (?<name>
        [^']+
    )
    '
    (?:
        \s+
        =>
        \s+
        '
        (?<version>
            [\d.]+
        )
        '
    )?
    ;
    \s*
    \z
}xmsio;

my @makefile = read_file($MAKEFILE);
chomp @makefile;

for  my $line  (@makefile) {
    if ($line =~ $get_mod_info) {
        my ($type, $name, $version) = @+{qw/ type  name  version /};
        $required_for{$type}->{$name} = ($version // 0);
    }
}
