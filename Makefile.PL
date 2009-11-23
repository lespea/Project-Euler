use inc::Module::Install;

name            'Project-Euler';
abstract_from   'lib/Project/Euler.pm';
license_from    'lib/Project/Euler.pm';
author          q{Adam Lesperance <lespea@gmail.com>};

requires    'Modern::Perl';
requires    'autodie';
requires    'Carp';

requires    'Moose';
requires    'Moose::Role';
requires    'Moose::Util::TypeConstraints';

requires    'DateTime';
requires    'DateTime::Format::Natural';

test_requires  'Test::More'  => '0.42';

perl_version '5.010';
version '0.10';

#auto_install;
WriteAll;
