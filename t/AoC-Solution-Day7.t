#!/usr/bin/env perl

use v5.36;
use strictures 2;

use Test::More;

use AoC::Solution::Day7;

my $solution = AoC::Solution::Day7->new(
    input => join("\n",
        '32T3K 765',
		'T55J5 684',
		'KK677 28',
		'KTJJT 220',
		'QQQJA 483',
    )
);

is($solution->part_1, 6440, 'part_1');
is($solution->part_2, 5905, 'part_2');

done_testing();
