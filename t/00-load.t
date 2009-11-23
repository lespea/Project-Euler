#!perl -T

use Test::More tests => 2;

BEGIN {
    use_ok( 'Project::Euler' );

    #  Using the template ensures that the base class compiles okay as well!
    use_ok( 'Project::Euler::Problem::problem_template' );
}

diag( "Testing Project::Euler $Project::Euler::VERSION, Perl $], $^X" );
