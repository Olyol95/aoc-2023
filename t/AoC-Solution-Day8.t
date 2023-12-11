#!/usr/bin/env perl

use v5.36;
use strictures 2;

use Test::More;

use AoC::Solution::Day8;

subtest part_1 => sub {
	my $solution = AoC::Solution::Day8->new(
		input => join("\n", (
			'LLR',
			'',
			'AAA = (BBB, BBB)',
			'BBB = (AAA, ZZZ)',
			'ZZZ = (ZZZ, ZZZ)',
		))
	);
	is($solution->part_1, 6, 'part_1');
};

subtest part_2 => sub {
	my $solution = AoC::Solution::Day8->new(
		input => join("\n", (
			'LR',
			'',
			'11A = (11B, XXX)',
			'11B = (XXX, 11Z)',
			'11Z = (11B, XXX)',
			'22A = (22B, XXX)',
			'22B = (22C, 22C)',
			'22C = (22Z, 22Z)',
			'22Z = (22B, 22B)',
			'XXX = (XXX, XXX)',
		))
	);
	is($solution->part_2, 6, 'part_2');
};

done_testing();
