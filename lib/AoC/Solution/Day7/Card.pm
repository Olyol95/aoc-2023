package AoC::Solution::Day7::Card;

use v5.36;
use strictures 2;

use Moo;

use AoC::Solution::Day7::CardType;

has type => (
    is       => 'ro',
    required => 1,
);

sub of {
    my ($char, %args) = @_;

    return AoC::Solution::Day7::Card->new(
        type => AoC::Solution::Day7::CardType::of($char, %args),
    );
}

sub compare {
    my ($self, $card) = @_;

    # Our card has a higher value
    if ($self->type > $card->type) {
        return 1;
    }

    # Their card has a higher value
    if ($self->type < $card->type) {
        return -1;
    }

    # Values are the same
    return 0;
}

1;
