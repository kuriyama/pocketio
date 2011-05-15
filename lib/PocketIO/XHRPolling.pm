package PocketIO::XHRPolling;

use strict;
use warnings;

use base 'PocketIO::Polling';

sub name {'xhr-polling'}

sub finalize {
    my $self = shift;
    my ($cb) = @_;

    my $req  = $self->req;
    my $name = $self->name;

    if ($req->method eq 'GET') {
        return $self->_finalize_init($cb) if $req->path =~ m{^/$name//\d+$};

        return $self->_finalize_stream($1)
          if $req->path =~ m{^/$name/(\d+)/\d+$};
    }

    return
      unless $req->method eq 'POST'
          && $req->path_info =~ m{^/$name/(\d+)/send$};

    return $self->_finalize_send($req, $1);
}

1;
__END__

=head1 NAME

PocketIO::XHRPolling - XHRPolling transport

=head1 DESCRIPTION

L<PocketIO::XHRPolling> is a C<xhr-polling> transport
implementation.

=head1 METHODS

=head2 C<name>

=head2 C<finalize>

=cut