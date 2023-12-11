#!/usr/bin/env perl

use v5.36;
use strictures 2;

use Test::More;

use AoC::Solution::Day9;

my $solution = AoC::Solution::Day9->new(
    input => join("\n", (
       	'0 3 6 9 12 15',
		'1 3 6 10 15 21',
		'10 13 16 21 30 45',
    ))
);

is($solution->part_1, 114, 'part_1');
is($solution->part_2, 2, 'part_2');

done_testing();
