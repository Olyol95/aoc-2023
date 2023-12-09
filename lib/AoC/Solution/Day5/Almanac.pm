package AoC::Solution::Day5::Almanac;

use v5.36;
use strictures 2;

use Moo;

use List::Util qw(min max);

use AoC::Solution::Day5::RangeMap;
use AoC::Solution::Day5::Range;

has from => (
    is       => 'ro',
    required => 1,
);

has to => (
    is       => 'ro',
    required => 1,
);

has _ranges => (
    is      => 'ro',
    default => sub { [] },
);

sub add_range {
    my ($self, $dest_start, $source_start, $length) = @_;

    push @{ $self->_ranges }, AoC::Solution::Day5::RangeMap->new(
        source => AoC::Solution::Day5::Range->new(
            start => $source_start,
            end   => $source_start + $length - 1,
        ),
        dest   => AoC::Solution::Day5::Range->new(
            start => $dest_start,
            end   => $dest_start + $length - 1,
        ),
    );
}

sub translate {
    my ($self, $value) = @_;

    foreach my $range (@{ $self->_ranges }) {
        return $range->translate($value) if $range->handles($value);
    }

    return $value;
}

sub translate_range {
    my ($self, $range) = @_;

    my @values;

    my $start = $range->start;
    my $source_ranges = $self->_source_ranges;
    foreach my $map_range (@$source_ranges) {
        # Map range is behind us
        if ($map_range->end < $start) {
            next;
        }
        # Map range intersects us
        elsif ($map_range->start <= $start && $map_range->end >= $start) {
            my $end = min($range->end, $map_range->end);
            push @values, AoC::Solution::Day5::Range->new(
                start => $self->translate($start),
                end   => $self->translate($end),
            );
            $start = $end + 1;
        }
        # Map range still ahead of us
        elsif ($map_range->start >= $start) {
            my $end = min($range->end, $map_range->start - 1);
            push @values, AoC::Solution::Day5::Range->new(
                start => $self->translate($start),
                end   => $self->translate($end),
            );
            $start = $end + 1;
        }
        last if $start >= $range->end;
    }

    # Our map ranges did not cover the entire range
    if ($start <= $range->end) {
        push @values, AoC::Solution::Day5::Range->new(
            start => $self->translate($start),
            end   => $self->translate($range->end),
        );
    }

    return \@values;
}

sub _source_ranges {
    my $self = shift;

    my @sources = map { $_->source } @{ $self->_ranges };
    return [ sort { $a->start <=> $b->start } @sources ];
}

1;
