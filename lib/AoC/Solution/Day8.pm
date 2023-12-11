package AoC::Solution::Day8;

use v5.36;
use strictures 2;

use Moo;

use Math::Utils qw(lcm);

with 'AoC::Solution';

sub part_1 {
    my $self = shift;

    return $self->_traverse('AAA', qw/ZZZ/);
}

sub part_2 {
    my $self = shift;

    my @locations = grep { $_ =~ /A$/ } keys %{ $self->input->{nodes} };

    return lcm map { $self->_traverse($_, qr/Z$/) } @locations;
}

sub _traverse {
    my ($self, $start, $end) = @_;

    my %map   = %{ $self->input->{nodes} };
    my @instr = @{ $self->input->{instructions} };
    my $wrap  = @instr;

    my $step  = 0;
    my $location = $start;
    until ($location =~ $end) {
        my $dir = $instr[$step++ % $wrap];
        $location = $map{$location}->{$dir};
    }

    return $step;
}

sub _parse_input {
    my $self = shift;

    my %input;
    foreach my $line (split /\n/, $self->input) {
        chomp $line;
        if ($line =~ /^([LR]+)$/) {
            $input{instructions} = [ split //, $1 ];
        }
        if ($line =~ /^(\w+) = \((\w+), (\w+)\)/) {
            $input{nodes}->{$1} = {
                L => $2,
                R => $3,
            };
        }
    }

    return \%input;
}

1;
