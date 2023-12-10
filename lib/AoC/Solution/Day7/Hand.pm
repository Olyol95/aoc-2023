package AoC::Solution::Day7::Hand;

use v5.36;
use strictures 2;

use Moo;

use AoC::Solution::Day7::Card;
use AoC::Solution::Day7::HandType;

has cards => (
    is       => 'ro',
    required => 1,
);

has type => (
    is      => 'lazy',
    default => sub {
        my $self = shift;
        return AoC::Solution::Day7::HandType::of($self->cards);
    },
);

sub of {
    my ($cards, %args) = @_;

    return AoC::Solution::Day7::Hand->new(
        cards => [
            map {
                AoC::Solution::Day7::Card::of($_, %args)
            } @$cards
        ],
    );
}

sub compare {
    my ($self, $hand) = @_;

    # Our hand type is more valuable
    if ($self->type > $hand->type) {
        return 1;
    }

    # Their hand type is more valuable
    if ($self->type < $hand->type) {
        return -1;
    }

    # Hand types are the same
    for (my $idx = 0; $idx <= $self->cards; $idx++) {
        my $ours   = $self->cards->[$idx];
        my $theirs = $hand->cards->[$idx];
        my $cmp    = $ours->compare($theirs);
        return $cmp if $cmp != 0;
    }

    return 0;
}

1;
