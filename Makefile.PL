use strict;
use warnings;

use inc::Module::Install;


perl_version '5.010';

extra_tests();
tests_recursive();


name            'Project-Euler';
abstract_from   'lib/Project/Euler.pm';
license_from    'lib/Project/Euler.pm';
version_from    'lib/Project/Euler.pm';
author_from     'lib/Project/Euler.pm';


#  Basic perl features
requires  'Modern::Perl' => '1.03';
requires  'autodie'      => '1.999';
requires  'Carp'         => '0.00';
requires  'version'      => '0.77';

#  Moose features
requires  'Moose'                        => '0.65';
requires  'Moose::Role'                  => '0.65';
requires  'MooseX::Types'                => '0.12';
requires  'Moose::Util::TypeConstraints' => '0.65';
requires  'MooseX::Method::Signatures'   => '0.09';

#  Other modules
requires  'DateTime'                    => '0.38';
requires  'DateTime::Format::DateParse' => '0.00';
requires  'List::MoreUtils'             => '0.13';
requires  'List::Util'                  => '1.20';
requires  'Math::Big'                   => '1.12';


#  Test modules
test_requires  'Test::More'      => '0.42';
test_requires  'Test::Most'      => '0.20';
test_requires  'Test::Exception' => '0.22';


#auto_install;
WriteAll;
