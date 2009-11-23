#!perl -T

use Test::More tests => 1;

BEGIN {
    use_ok( 'Project::Euler' );
}

diag( "Testing Project::Euler $Project::Euler::VERSION, Perl $], $^X" );
