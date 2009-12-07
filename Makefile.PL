use inc::Module::Install;

name            'Project-Euler';
abstract_from   'lib/Project/Euler.pm';
license_from    'lib/Project/Euler.pm';
version_from    'lib/Project/Euler.pm';
author          q{Adam Lesperance <lespea@gmail.com>};

requires    'Modern::Perl';
requires    'autodie';
requires    'Carp';
requires    'version' => '0.77';

requires    'Moose';
requires    'Moose::Role';
requires    'MooseX::Types';
requires    'Moose::Util::TypeConstraints';
requires    'MooseX::Method::Signatures';

requires    'DateTime';
requires    'DateTime::Format::DateParse';
requires    'List::MoreUtils';

test_requires  'Test::More'      => '0.42';
test_requires  'Test::Exception';

perl_version '5.010';

auto_install;
WriteAll;
