package AoC::Solution::Day7::CardType;

use v5.36;
use strictures 2;

use Scalar::Util qw(dualvar);
use Exporter qw(import);

our @EXPORT_OK = qw(
    is_joker
);

sub of {
    my ($char, %args) = @_;

    my %card_ranks = (
        'A' => 14,
        'K' => 13,
        'Q' => 12,
        'J' => 11,
        'T' => 10,
    );

    if ($args{jokers}) {
        $card_ranks{J} = 1;
    }

    if (exists $card_ranks{$char}) {
        return dualvar($card_ranks{$char}, $char);
    }

    return dualvar($char, int $char);
}

sub is_joker {
    my $type = shift;

    return $type eq 'J'
        && $type == 1;
}

1;
