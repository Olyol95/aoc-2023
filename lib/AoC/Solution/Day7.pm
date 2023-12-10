package AoC::Solution::Day7;

use v5.36;
use strictures 2;

use Moo;

use List::Util qw(sum);

use AoC::Solution::Day7::Hand;

with 'AoC::Solution';

sub part_1 {
    my $self = shift;

    my @players;
    foreach my $player (@{ $self->input }) {
        push @players, {
            bid  => $player->{bid},
            hand => AoC::Solution::Day7::Hand::of($player->{hand}, jokers => 0),
        };
    }

    return $self->_winnings(\@players);
}

sub part_2 {
    my $self = shift;

    my @players;
    foreach my $player (@{ $self->input }) {
        push @players, {
            bid  => $player->{bid},
            hand => AoC::Solution::Day7::Hand::of($player->{hand}, jokers => 1),
        };
    }

    return $self->_winnings(\@players);
}

sub _winnings {
    my ($self, $players) = @_;

    my @sorted = sort {
        $a->{hand}->compare($b->{hand})
    } @$players;

    my $rank = 1;
    return sum map { $rank++ * $_->{bid} } @sorted;
}

sub _parse_input {
    my $self = shift;

    my @input;
    foreach my $line (split /\n/, $self->input) {
        my ($hand, $bid) = split /\s+/, $line;
        push @input, {
            bid  => $bid,
            hand => [ split //, $hand ],
        };
    }

    return \@input;
}

1;
