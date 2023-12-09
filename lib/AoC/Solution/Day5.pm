package AoC::Solution::Day5;

use v5.36;
use strictures 2;

use Moo;

use List::Util qw(min);

use AoC::Solution::Day5::Almanac;
use AoC::Solution::Day5::Range;

with 'AoC::Solution';

sub part_1 {
    my $self = shift;

    return min(
        map {
            $self->_translate('seed' => 'location', $_)
        } @{ $self->input->{seeds} }
    );
}

sub part_2 {
    my $self = shift;

    my @seed_ranges;

    my %seeds = @{ $self->input->{seeds} };
    while (my ($start, $length) = each %seeds) {
        push @seed_ranges, AoC::Solution::Day5::Range->new(
            start => $start,
            end   => $start + $length - 1,
        );
    }

    return min(
        map { $_->start }
        @{ $self->_translate_ranges('seed' => 'location', \@seed_ranges) }
    );
}

sub _translate {
    my ($self, $from, $to, $value) = @_;

    do {
        my $almanac = $self->_almanac(from => $from);
        $from  = $almanac->to;
        $value = $almanac->translate($value);
    } while ($from ne $to);

    return $value;
}

sub _translate_ranges {
    my ($self, $from, $to, $ranges) = @_;

    my @ranges = @$ranges;

    do {
        my $almanac = $self->_almanac(from => $from);
        $from = $almanac->to;
        @ranges = map { @{ $almanac->translate_range($_) } } @ranges;
    } while ($from ne $to);

    return \@ranges;
}

sub _almanac {
    my ($self, $field, $value) = @_;

    foreach my $almanac (@{ $self->input->{almanac} }) {
        return $almanac if $almanac->$field eq $value;
    }

    return;
}

sub _parse_input {
    my $self = shift;

    my @seeds;
    if ($self->input =~ /seeds: (.+)/) {
        @seeds = split / /, $1;
    }

    my %input = (
        seeds   => \@seeds,
        almanac => [],
    );

    my $almanac;
    foreach my $line (split /\n/, $self->input) {
        if ($line =~ /^$/) {
            push @{ $input{almanac} }, $almanac if $almanac;
        }
        elsif ($line =~ /([^-]+)-to-([^ ]+) map:/) {
            $almanac = AoC::Solution::Day5::Almanac->new(
                from => $1,
                to   => $2,
            );
        }
        else {
            next unless $almanac;
            $almanac->add_range(split(/ /, $line));
        }
    }
    push @{ $input{almanac} }, $almanac;

    return \%input;
}

1;
