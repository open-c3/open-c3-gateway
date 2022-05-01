#!/usr/bin/env perl

use strict;
use warnings;

my ( $timeout, $cachetimeout, $now ) = ( 300, 86400, time  );
my ( $cookie, $locked ) = map{ "/data/open-c3-gateway/data/$_" } qw( cookie locked );

my @x = `tail -n 5000 /data/open-c3-gateway/logs/lua/error.log |grep cookieinfo`;
chomp @x;
my %x;

for( @x )
{
    next unless $_ =~ /cookieinfo:\[(\d+):([a-z0-9]{32})\]/;
    $x{$2} = $1;
}

for my $x ( keys %x )
{
    my $time = $x{$x};
    next unless $time && $time =~ /^\d+$/ && $time + $cachetimeout > $now;
    system "echo $time > $cookie/$x";
}

for my $x ( glob "$cookie/*" )
{
    my $name = ( split /\//, $x )[-1];
    next unless $name =~ /^[a-z0-9]{32}$/;
    my $time = `cat '$x'`;
    chomp $time;
    next unless $time && $time =~ /^\d+$/ && $time + $timeout < $now;
    my $file = "$locked/$name";
    next if -f $file;
    system "echo $now > $file";
}

for my $x ( glob( "$cookie/*" ), glob( "$locked/*" ) )
{
    my $name = ( split /\//, $x )[-1];
    next unless $name =~ /^[a-z0-9]{32}$/;
    my $time = `cat '$x'`;
    chomp $time;
    next unless $time && $time =~ /^\d+$/ && $time + $cachetimeout < $now;
    unlink $x;
}
