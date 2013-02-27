#!/usr/bin/perl -w

use strict;
use warnings;
use Proc::Daemon;

my $daemon = Proc::Daemon->new(
	work_dir     => '/opt/ws2812XmlServer',
	child_STDOUT => '/opt/ws2812XmlServer/ws2812XmlServer.log',
	child_STDERR => '+>>ws2812XmlServer.err',
	pid_file     => 'ws2812XmlServer.pid',
	exec_command => 'perl /opt/ws2812XmlServer/ws2812XmlServer.pl',
);

my $pid = $daemon->Init();
