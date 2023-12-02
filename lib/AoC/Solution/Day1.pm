package AoC::Solution::Day1;

use v5.36;
use strictures 2;

use Moo;

use List::Util qw(sum);

with 'AoC::Solution';

sub part_1 {
    my $self = shift;

    my $lines = $self->_get_digits(
        qr/\d/
    );

    return sum(
        map { $_->[0] . $_->[-1] } @$lines
    );
}

sub part_2 {
    my $self = shift;

    my $lines = $self->_get_digits(
        qr/(?=(\d|one|two|three|four|five|six|seven|eight|nine))/
    );

    return sum(
        map { $_->[0] . $_->[-1] } @$lines
    );
}

sub _get_digits {
    my ($self, $pattern) = @_;

    my @lines;
    foreach my $line (@{ $self->input }) {
        my @matches = $line =~ /$pattern/g;
        push @lines, [ map { $self->_value_of($_) } @matches ];
    }

    return \@lines;
}

sub _value_of {
    my ($self, $input) = @_;

    my %values = (
        one   => 1,
        two   => 2,
        three => 3,
        four  => 4,
        five  => 5,
        six   => 6,
        seven => 7,
        eight => 8,
        nine  => 9,
    );

    if (exists $values{$input}) {
        return $values{$input};
    }

    return $input;
}

1;
