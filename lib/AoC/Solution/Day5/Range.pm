package AoC::Solution::Day5::Range;

use v5.36;
use strictures 2;

use Moo;

has start => (
    is       => 'ro',
    required => 1,
);

has end => (
    is       => 'ro',
    required => 1,
);

sub handles {
    my ($self, $value) = @_;

    return $value >= $self->start
        && $value <= $self->end;
}

1;
