#!/usr/bin/env perl

use v5.36;
use strictures 2;
use syntax 'qs';

use Test::More;

use AoC::Solution::Day6;

my $solution = AoC::Solution::Day6->new(
    input => qs{
        Time:      7  15   30
        Distance:  9  40  200
    }
);

is($solution->part_1, 288, 'part_1');
is($solution->part_2, 71503, 'part_2');

done_testing();
