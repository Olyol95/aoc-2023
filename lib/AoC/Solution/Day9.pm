package AoC::Solution::Day9;

use v5.36;
use strictures 2;

use Moo;

use List::Util qw(sum);

with 'AoC::Solution';

sub part_1 {
    my $self = shift;

    return sum map { $self->_extrapolate($_) } @{ $self->input };
}

sub part_2 {
    my $self = shift;

    my @reversed = map { [ reverse @$_ ] } @{ $self->input };

    return sum map { $self->_extrapolate($_) } @reversed;
}

sub _extrapolate {
    my ($self, $sequence) = @_;

    my @diffs;
    for (my $idx = 0; $idx < @$sequence - 1; $idx++) {
        push @diffs, $sequence->[$idx + 1] - $sequence->[$idx];
    }

    if (sum @diffs == 0) {
        return $sequence->[-1];
    }

    return $sequence->[-1] + $self->_extrapolate(\@diffs);
}

sub _parse_input {
    my $self = shift;

    return [ map { [ split /\s+/, $_] } split /\n/, $self->input ];
}

1;
