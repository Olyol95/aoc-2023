package AoC::Solution::Day3;

use v5.36;
use strictures 2;

use Moo;

use List::Util qw(sum uniq);

use AoC::Solution::Day3::Grid;

with 'AoC::Solution';

has grid => (
    is      => 'lazy',
    builder => '_build_grid',
);

sub part_1 {
    my $self = shift;

    return sum $self->_valid_part_numbers;
}

sub part_2 {
    my $self = shift;

    return sum $self->_gear_ratios;
}

sub _gear_ratios {
    my $self = shift;

    my $gears = $self->grid->symbol_locations(qr/[*]/);

    my @ratios;
    foreach my $location (@$gears) {
        my $neighbours = $self->_neighbouring_parts($location);
        next unless scalar @$neighbours == 2;
        push @ratios, $neighbours->[0] * $neighbours->[1];
    }

    return @ratios;
}

sub _valid_part_numbers {
    my $self = shift;

    return map {
        @{ $self->_neighbouring_parts($_) }
    } @{ $self->grid->symbol_locations };
}

sub _neighbouring_parts {
    my ($self, $location) = @_;

    my @parts;
    for (my $dy = -1; $dy <= 1; $dy++) {
        for (my $dx = -1; $dx <= 1; $dx++) {
            my ($x, $y) = ($location->{x} + $dx, $location->{y} + $dy);
            my $part = $self->grid->point($x, $y);
            push @parts, $part if $part && $part =~ /\d+/;
        }
    }

    return [ uniq @parts ];
}

sub _parse_input {
    my $self = shift;

    return [
        map { [ split //, $_ ] }
        split /\n/, $self->input
    ];
}

sub _build_grid {
    my $self = shift;

    my $grid = AoC::Solution::Day3::Grid->new(
        width  => scalar @{ $self->input->[0] },
        height => scalar @{ $self->input },
    );

    for (my $y = 0; $y < $grid->height; $y++) {
        my ($value, $start, $end);
        for (my $x = 0; $x < $grid->width; $x++) {
            my $char = $self->input->[$y]->[$x];
            if ($char =~ /\d/) {
                $value .= $char;
                $start = $x unless defined $start;
                $end   = $x;
            }
            elsif ($char !~ /[.]/) {
                $grid->point($x, $y, $char);
            }
            if (defined $value && ($char !~ /\d/ || $x == scalar @{ $self->input->[$y] } - 1)) {
                $grid->point($_, $y, $value) foreach ($start..$end);
                ($value, $start, $end) = undef;
            }
        }
    }

    return $grid;
}

1;
