#!/usr/bin/env perl

use v5.36;
use strictures 2;

use Test::More;

use AoC::Solution::Day3;

my $solution = AoC::Solution::Day3->new(
    input => join("\n", (
        '467..114..',
        '...*......',
        '..35..633.',
        '......#...',
        '617*......',
        '.....+.58.',
        '..592.....',
        '......755.',
        '...$.*....',
        '.664.598..',
    ))
);

is($solution->part_1, 4361, 'part_1');
is($solution->part_2, 467835, 'part_2');

done_testing();
