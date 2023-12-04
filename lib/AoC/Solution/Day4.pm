package AoC::Solution::Day4;

use v5.36;
use strictures 2;

use Moo;

use List::Util qw(sum);

with 'AoC::Solution';

sub part_1 {
    my $self = shift;

    return sum(
        map { $self->_card_score($_) } @{ $self->_card_ids }
    );
}

sub part_2 {
    my $self = shift;

    my @ids = @{ $self->_card_ids };
    my %copies = map { $_ => 1 } @ids;

    foreach my $id (@ids) {
        my $wins = $self->_total_wins($id);
        foreach my $copy_id ($id + 1 .. $id + $wins) {
            if (exists $copies{$copy_id}) {
                $copies{$copy_id} += $copies{$id};
            }
        }
    }

    return sum values %copies;
}

sub _card_ids {
    my $self = shift;

    return [ sort { $a <=> $b } keys %{ $self->input } ];
}

sub _card_score {
    my ($self, $id) = @_;

    my $wins = $self->_total_wins($id);

    if ($wins) {
        return 2 ** ($wins - 1);
    }

    return 0;
}

sub _total_wins {
    my ($self, $id) = @_;

    my $card = $self->input->{$id};

    return scalar grep {
        exists $card->{winning}->{$_}
    } @{ $card->{numbers} };
}

sub _parse_input {
    my $self = shift;

    my %cards;
    foreach my $line (split /\n/, $self->input) {
        next unless $line =~ /(\d+):\s+([^|]+)\s+[|]\s+(.+)/;
        $cards{$1} = {
            winning => { map { $_ => 1 } split /\s+/, $2 },
            numbers => [ split /\s+/, $3 ],
        };
    }

    return \%cards;
}

1;
