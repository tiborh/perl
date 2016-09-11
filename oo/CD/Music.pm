package CD::Music;

use strict;

sub new {
    my ($class) = @_;
    bless{
	_name => $_[1]     || "unnamed",
	_artist=> $_[2]    || "noname",
	_publisher=> $_[3] || "unpublished",
	_ISBN=> $_[4]      || "0000000000",
	_tracks=> $_[5]    || 0,
	_room=> $_[6]      || "000",
	_shelf=> $_[7]     || "00",
	_rating=> $_[8]    || undef,
    }, $class;
}

sub name{ $_[0]->{_name}}
sub artist{ $_[0]->{_artist}}
sub publisher{ $_[0]->{_publisher}}
sub ISBN{ $_[0]->{_ISBN}}
sub tracks{ $_[0]->{_tracks}}
sub location {
    my ($self, $shelf, $room) = @_;
    $self->{_room}= $room if $room;
    $self->{_shelf}= $shelf if $shelf;
    return ($self->{_room}, $self->{_shelf});
}
sub rating {
    my ($self, $rating) = @_;
    $self->{_rating} = $rating if defined $rating;
    return $self->{_rating};
}
1;
