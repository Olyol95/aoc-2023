package AoC::Solution::Day5::RangeMap;

use v5.36;
use strictures 2;

use Moo;

has source => (
    is       => 'ro',
    required => 1,
);

has dest => (
    is       => 'ro',
    required => 1,
);

has offset => (
    is      => 'lazy',
    default => sub {
        my $self = shift;
        return $self->dest->start - $self->source->start;
    },
);

sub handles {
    my ($self, $value) = @_;

    return $self->source->handles($value);
}

sub translate {
    my ($self, $value) = @_;

    return $value + $self->offset;
}

1;
