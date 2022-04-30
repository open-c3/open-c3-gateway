#!/data/mydan/perl/bin/perl

use strict;
use warnings;

my @x = `tail -n 5000 /data/open-c3-gateway/logs/lua/error.log |grep cookieinfo`;
chomp @x;
my %x;

for( @x )
{
    next unless $_ =~ /cookieinfo:\[(\d+):([a-z0-9]{32})\]/;
    $x{$2} = $1;
}

my ( $cookie, $locked ) = map{ "/data/open-c3-gateway/data/$_" } qw( cookie locked );

for my $x ( keys %x )
{
    system "echo $x{$x} > $cookie/$x";
}

for my $x ( glob "$cookie/*" )
{
    my $name = ( split /\//, $x )[-1];
    next unless $name =~ /^[a-z0-9]{32}$/;
    my $time = `cat '$x'`;
    chomp $time;
    next unless $time && $time =~ /^\d+$/ && $time + 300 < time;
    my $file = "$locked/$name";
    next if -f $file;
    system "touch $file";
}
