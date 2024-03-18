#!/usr/bin/perl

use strict;

my $first = 1;

print "{\n";
print "\t\"data\":[\n\n";

my $VEname = `hostname`;
chomp($VEname); # Loại bỏ ký tự xuống dòng

my $lxcresult = `/snap/bin/lxc list --format=json | jq -r '.[].name'`;

my @lines = split /\n/, $lxcresult;
foreach my $l (@lines) {
    my $id = $l;
    my $status = `/snap/bin/lxc info $id | grep Status | awk '{print \$2}'`;
    chomp($status); # Loại bỏ ký tự xuống dòng

    print ",\n" if not $first;
    $first = 0;

    print "\t{\n";
    print "\t\t\"{#CTID}\":\"$id\",\n";
    print "\t\t\"{#CTSTATUS}\":\"$status\",\n";
    print "\t\t\"{#VENAME}\":\"$VEname\"\n";
    print "\t}";
}

print "\n\t]\n";
print "}\n";
