package AoC::Solution::Day2;

use v5.36;
use strictures 2;

use Moo;

use Const::Fast;
use List::Util qw(max sum);

with 'AoC::Solution';

const my $COLOURS => [qw(red green blue)];

sub part_1 {
    my $self = shift;

    return sum(
        map {
            $self->_is_possible(
                $self->_min_set($_->{sets})
            ) ? $_->{id} : 0
        } @{ $self->input }
    );
}

sub part_2 {
    my $self = shift;

    return sum(
        map {
            $self->_set_power(
                $self->_min_set($_->{sets})
            )
        } @{ $self->input }
    );
}

sub _set_power {
    my ($self, $set) = @_;

    return $set->{red}
        * $set->{green}
        * $set->{blue};
}

sub _is_possible {
    my ($self, $set) = @_;

    return $set->{red} <= 12
        && $set->{green} <= 13
        && $set->{blue} <= 14;
}

sub _min_set {
    my ($self, $sets) = @_;

    my %set;
    foreach my $colour (@$COLOURS) {
        $set{$colour} = max( map { $_->{$colour} } @$sets );
    }

    return \%set;
}

sub _parse_input {
    my $self = shift;

    my @games;
    foreach my $line (split /\n/, $self->input) {
        my ($game_id, $sets) = $line =~ /Game (\d+):(.+)/;
        push @games, {
            id   => $game_id,
            sets => $self->_parse_sets($sets),
        };
    }

    return \@games;
}

sub _parse_sets {
    my ($self, $string) = @_;

    my @sets;
    foreach my $chunk (split /;/, $string) {
        my %set;
        foreach my $colour (@$COLOURS) {
            if ($chunk =~ /(\d+) $colour/) {
                $set{$colour} = $1;
            }
            else {
                $set{$colour} = 0;
            }
        }
        push @sets, \%set;
    }

    return \@sets;
}

1;
