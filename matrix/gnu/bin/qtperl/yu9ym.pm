#!/usr/bin/perl -w

use Hash::Util::FieldHash;
use strict;
use warnings;

# Define a hash to store the data
my %data = (
    'John' => { age => 30, city => 'New York' },
    'Mark' => { age => 28, city => 'Los Angeles' },
    'Mike' => { age => 35, city => 'Chicago' },
);

# Create a FieldHash object
my $fh = FieldHash->new(\%data);

# Add a new person's data
$fh->add('Sarah', { age => 32, city => 'San Francisco' });

# Update an existing person's data
$fh->update('John', { age => 31, city => 'Boston' });

# Delete a person's data
$fh->delete('Mike');

# Print the updated hash
print "Updated hash:\n";
foreach my $person (sort keys %data) {
    print "$person:\n";
    print "  Age: $data{$person}->{age}\n";
    print "  City: $data{$person}->{city}\n";
}

# Search for a person by name
my $found_person = $fh->find('Sarah');
if ($found_person) {
    print "Found Sarah:\n";
    print "  Age: $found_person->{age}\n";
    print "  City: $found_person->{city}\n";
} else {
    print "Person not found.\n";
}

local $SIG{INT} = sub { exit 0 };

sub usage {
    print "Usage: $0 [add|update|delete|search]\n";
    exit 1;
}

my $action = $ARGV[0];

if ($action eq 'add' || $action eq 'update' || $action eq 'delete' || $action eq 'search') {
    if (@ARGV < 2) {
        usage();
    }

    my $person = $ARGV[1];

    if ($action eq 'add') {
        my $age = $ARGV[2] || 0;
        my $city = $ARGV[3] || '';
        $fh->add($person, { age => $age, city => $city });
    } elsif ($action eq 'update') {
        my $age = $ARGV[2] || 0;
        my $city = $ARGV[3] || '';
        $fh->update($person, { age => $age, city => $city });
    } elsif ($action eq 'delete') {
        $fh->delete($person);
        print "Deleted $person.\n";
        exit 0;
        } elsif ($action eq 'search') {
        my $found_person = $fh->find($person);
        if ($found_person) {
            print "Found $person:\n";
            print "  Age: $found_person->{age}\n";
            print "  City: $found_person->{city}\n";
            exit 0;
            } else {
            print "Person not found.\n";
            exit 1;
            }
    }
    } else {
    usage();
    }
    