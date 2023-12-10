package AoC::Solution::Day6;

use v5.36;
use strictures 2;

use Moo;

use List::Util qw(product);

with 'AoC::Solution';

sub part_1 {
    my $self = shift;

    return product(
        map { $self->_winning_options($_) }
        @{ $self->input }
    );
}

sub part_2 {
    my $self = shift;

    my %race = (
        time     => '',
        distance => '',
    );

    foreach my $r (@{ $self->input }) {
        $race{time} .= $r->{time};
        $race{distance} .= $r->{distance};
    }

    return $self->_winning_options(\%race);
}

sub _winning_options {
    my ($self, $race) = @_;

    my %bounds;

    my $press = 1;
    while (1) {
        my $distance = $self->_distance($press, $race->{time});
        if ($distance > $race->{distance}) {
            $bounds{lower} = $press;
            last;
        }
        $press++;
    }

    $press = $race->{time} - 1;
    while (1) {
        my $distance = $self->_distance($press, $race->{time});
        if ($distance > $race->{distance}) {
            $bounds{upper} = $press;
            last;
        }
        $press--;
    }

    return $bounds{upper} - $bounds{lower} + 1;
}

sub _distance {
    my ($self, $press_time, $total_time) = @_;

    return $press_time * ($total_time - $press_time);
}

sub _parse_input {
    my $self = shift;

    my @times;
    if ($self->input =~ /Time:\s+(.+)/g) {
        @times = split /\s+/, $1;
    }

    my @dists;
    if ($self->input =~ /Distance:\s+(.+)/g) {
        @dists = split /\s+/, $1;
    }

    return [
        map { { time => $times[$_], distance => $dists[$_] } }
        0 .. @times - 1
    ];
}

1;
