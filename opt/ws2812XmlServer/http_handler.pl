#!/usr/bin/perl -w
use Config::Tiny;
use Time::HiRes qw(usleep nanosleep);

sub http_request_handler {
  my $fh     =   shift;
  my $req_   =   shift;

  my %req    =   %$req_;

  my %header = %{$req{HEADER}};

system( '/opt/ws2812XmlServer/ws2812XmlServer.sh' );
usleep(300000);

my $Config = Config::Tiny->new();
$Config = Config::Tiny->read( '/opt/ws2812XmlServer/ws2812XmlServer.out' );

my $time_last_actualisation = $Config->{time}->{last_actualisation};
my $weather_picture_number = $Config->{weather_picture}->{number};
my $weather_tendency_number = $Config->{weather_tendency}->{number};
my $storm_alarm_number = $Config->{storm_alarm}->{number};
my $indoor_temperature_deg_C = $Config->{indoor_temperature}->{deg_C};
my $outdoor_temperature_deg_C = $Config->{outdoor_temperature}->{deg_C};
my $indoor_humidity_percent = $Config->{indoor_humidity}->{percent};
my $outdoor_humidity_percent = $Config->{outdoor_humidity}->{percent};
my $dewpoint_deg_C = $Config->{dewpoint}->{deg_C};
my $windchill_deg_C = $Config->{windchill}->{deg_C};
my $wind_speed_kmh = $Config->{wind_speed}->{kmh};
my $wind_direction_deg = $Config->{wind_direction}->{deg};
my $wind_direction_name = $Config->{wind_direction}->{name};
my $rain_total_mm = $Config->{rain_total}->{mm};
my $rain_24h_mm = $Config->{rain_24h}->{mm};
my $rain_1h_mm = $Config->{rain_1h}->{mm};
my $pressure_relative_hpa = $Config->{pressure_relative}->{hpa};

$time_last_actualisation =~ tr/\"//d; 
$indoor_temperature_deg_C =~ tr/\"//d;
$outdoor_temperature_deg_C =~ tr/\"//d;
$indoor_humidity_percent =~ tr/\"//d;
$outdoor_humidity_percent =~ tr/\"//d;
$dewpoint_deg_C =~ tr/\"//d;
$windchill_deg_C =~ tr/\"//d;
$wind_speed_kmh =~ tr/\"//d;
$wind_direction_deg =~ tr/\"//d;
$wind_direction_name =~ tr/\"//d;
$rain_total_mm =~ tr/\"//d;
$rain_24h_mm =~ tr/\"//d;
$rain_1h_mm =~ tr/\"//d;
$pressure_relative_hpa =~ tr/\"//d;

my $out = sprintf("HTTP/1.0 200 OK\r\n");
$out .= sprintf("Content-Type: text/xml\r\n");
$out .= sprintf("Pragma: no-cache\r\n");
$out .= sprintf("Expires: -1\r\n");
$out .= sprintf("Access-Control-Allow-Origin: *\r\n");
$out .= sprintf("Connection: close\r\n\r\n");
$out .= sprintf("<?xml version=\"1.0\" encoding=\"UTF-8\"?>\r\n");
$out .= sprintf("<eeml xmlns=\"http://www.eeml.org/xsd/0.5.1\" xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" version=\"0.5.1\" xsi:schemaLocation=\"http://www.eeml.org/xsd/0.5.1 http://www.eeml.org/xsd/0.5.1/0.5.1.xsd\">\r\n");
$out .= sprintf("<environment>\r\n");
$out .= sprintf("<data id=\"time_last_actualisation\">\r\n<value>$time_last_actualisation</value>\r\n</data>\r\n");
$out .= sprintf("<data id=\"weather_picture_number\">\r\n<value>$weather_picture_number</value>\r\n</data>\r\n");
$out .= sprintf("<data id=\"weather_tendency_number\">\r\n<value>$weather_tendency_number</value>\r\n</data>\r\n");
$out .= sprintf("<data id=\"storm_alarm_number\">\r\n<value>$storm_alarm_number</value>\r\n</data>\r\n");
$out .= sprintf("<data id=\"indoor_temperature_deg_C\">\r\n<value>$indoor_temperature_deg_C</value>\r\n</data>\r\n");
$out .= sprintf("<data id=\"outdoor_temperature_deg_C\">\r\n<value>$outdoor_temperature_deg_C</value>\r\n</data>\r\n");
$out .= sprintf("<data id=\"indoor_humidity_percent\">\r\n<value>$indoor_humidity_percent</value>\r\n</data>\r\n");
$out .= sprintf("<data id=\"outdoor_humidity_percent\">\r\n<value>$outdoor_humidity_percent</value>\r\n</data>\r\n");
$out .= sprintf("<data id=\"dewpoint_deg_C\">\r\n<value>$dewpoint_deg_C</value>\r\n</data>\r\n");
$out .= sprintf("<data id=\"windchill_deg_C\">\r\n<value>$windchill_deg_C</value>\r\n</data>\r\n");
$out .= sprintf("<data id=\"wind_speed_kmh\">\r\n<value>$wind_speed_kmh</value>\r\n</data>\r\n");
$out .= sprintf("<data id=\"wind_direction_deg\">\r\n<value>$wind_direction_deg</value>\r\n</data>\r\n");
$out .= sprintf("<data id=\"wind_direction_name\">\r\n<value>$wind_direction_name</value>\r\n</data>\r\n");
$out .= sprintf("<data id=\"rain_total_mm\">\r\n<value>$rain_total_mm</value>\r\n</data>\r\n");
$out .= sprintf("<data id=\"rain_24h_mm\">\r\n<value>$rain_24h_mm</value>\r\n</data>\r\n");
$out .= sprintf("<data id=\"rain_1h_mm\">\r\n<value>$rain_1h_mm</value>\r\n</data>\r\n");
$out .= sprintf("<data id=\"pressure_relative_hpa\">\r\n<value>$pressure_relative_hpa</value>\r\n</data>\r\n");
$out .= sprintf("</environment>\r\n</eeml>\r\n");

print $fh $out;

}

sub init_webserver_extension {
  $port_listen = 8016;
}

1;

