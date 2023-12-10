package AoC::Solution::Day7::HandType;

use v5.36;
use strictures 2;

use Const::Fast;
use List::Util qw(max);
use Scalar::Util qw(dualvar);

use AoC::Solution::Day7::CardType qw(is_joker);

const my $FIVE_OF_A_KIND  => dualvar(7, 'five of a kind');
const my $FOUR_OF_A_KIND  => dualvar(6, 'four of a kind');
const my $FULL_HOUSE      => dualvar(5, 'full house');
const my $THREE_OF_A_KIND => dualvar(4, 'three of a kind');
const my $TWO_PAIR        => dualvar(3, 'two pair');
const my $ONE_PAIR        => dualvar(2, 'one pair');
const my $HIGH_CARD       => dualvar(1, 'high card');

sub of {
    my $cards = shift;

    my %counts;
    my $jokers = 0;
    foreach my $card (@$cards) {
        if (is_joker($card->type)) {
            $jokers++;
            next;
        }
        $counts{$card->type}++;
    }

    if (keys %counts == 5) {
        return $HIGH_CARD;
    }
    if (keys %counts == 4) {
        return $ONE_PAIR;
    }
    if (keys %counts == 3) {
        if (max(values %counts) == 2 && !$jokers) {
            return $TWO_PAIR;
        }
        return $THREE_OF_A_KIND;
    }
    if (keys %counts == 2) {
        if (max(values %counts) == 3) {
            return $jokers
                ? $FOUR_OF_A_KIND
                : $FULL_HOUSE;
        }
        return $jokers == 1
            ? $FULL_HOUSE
            : $FOUR_OF_A_KIND;
    }
    if (keys %counts == 1 || $jokers) {
        return $FIVE_OF_A_KIND;
    }

    die "failed to parse hand type";
}

1;
