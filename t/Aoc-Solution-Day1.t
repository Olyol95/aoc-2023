#!/usr/bin/env perl

use v5.36;
use strictures 2;

use Test::More;

use AoC::Solution::Day1;

subtest part_1 => sub {
    my $solution = AoC::Solution::Day1->new(
        input => join("\n", qw(
            1abc2
            pqr3stu8vwx
            a1b2c3d4e5f
            treb7uchet
        ))
    );

    is($solution->part_1, 142, 'part_1');
};

subtest part_2 => sub {
    my $solution = AoC::Solution::Day1->new(
        input => join("\n", qw(
            two1nine
            eightwothree
            abcone2threexyz
            xtwone3four
            4nineeightseven2
            zoneight234
            7pqrstsixteen
        ))
    );

    is($solution->part_2, 281, 'part_2');
};

done_testing();
