use inc::Module::Install;

name     'Project-Euler';
all_from 'lib/Project/Euler.pm';
author   q{Adam Lesperance <lespea@gmail.com>};
license  'perl';

build_requires 'Test::More';

auto_install;

WriteAll;

