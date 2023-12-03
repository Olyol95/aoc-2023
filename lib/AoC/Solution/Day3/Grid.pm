package AoC::Solution::Day3::Grid;

use v5.36;
use strictures 2;

use Moo;

has width => (
    is       => 'ro',
    required => 1,
);

has height => (
    is       => 'ro',
    required => 1,
);

has _points => (
    is      => 'ro',
    default => sub { {} },
);

sub point {
    my ($self, $x, $y, $value) = @_;

    if (defined $value) {
        $self->_points->{"$x,$y"} = $value;
    }

    return $self->_points->{"$x,$y"};
}

sub symbol_locations {
    my ($self, $pattern) = @_;

    $pattern //= qr/\D/;

    my @locations;
    while (my ($key, $value) = each %{ $self->_points }) {
        next unless $value =~ $pattern;
        my ($x, $y) = split /,/, $key;
        push @locations, {
            x => $x,
            y => $y,
        };
    }

    return \@locations;
}

1;
