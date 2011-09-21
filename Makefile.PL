use inc::Module::Install;
name 'Dicty-Migration';
all_from 'lib/Dicty/Migration.pm';

# requires '';

tests 't/*.t';
author_tests 'xt';

test_requires 'Test::More';
auto_set_repository;
auto_include;
WriteAll;
