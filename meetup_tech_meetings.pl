#!perl

use strict;
use warnings;
use feature qw/ say /;

use Cpanel::JSON::XS qw/ decode_json /;
use File::Slurper qw/ read_text /;
use Encode qw/ decode encode /;
use Lingua::EN::Inflect qw/ NUMWORDS ORD /;
use DateTime;

my $json_str = encode( 'UTF-8',read_text( shift ) );
my $data     = decode_json( $json_str );

my @tech_meetings = reverse
    grep { $_->{name} =~ /technical meeting/i }
    @{ $data };

my $i = 1;

foreach my $tech_meeting ( @tech_meetings ) {

    # meetups epoch times have milisecond precision
    my $time = $tech_meeting->{time} =~ s/\d{3}$//r;

    my $date = DateTime->from_epoch( epoch => $time );
    my $ordinal_day = ORD( $date->day );

    say <<"EndOfHTML";
<h2>Technical Meeting - @{[ $date->strftime( "%b $ordinal_day %Y" ) ]}</h2><div class="item">
    <p>London.pm holds a technical meeting.</p>
</div>

EndOfHTML

    # if meetup does have the full composite of meetings (don't think it does)
    # <p>London.pm holds its @{[ NUMWORDS( ORD( $i++ ) ) ]} technical meeting.</p>
}

__END__
