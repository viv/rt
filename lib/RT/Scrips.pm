# Copyright 1999-2001 Jesse Vincent <jesse@fsck.com>
# Released under the terms of the GNU Public License
# $Header$

=head1 NAME

  RT::Scrips - a collection of RT Scrip objects

=head1 SYNOPSIS

  use RT::Scrips;

=head1 DESCRIPTION


=head1 METHODS

=cut

package RT::Scrips;
use RT::EasySearch;
use RT::Scrip
@ISA= qw(RT::EasySearch);


# {{{ sub _Init
sub _Init { 
  my $self = shift;
  $self->{'table'} = "Scrips";
  $self->{'primary_key'} = "id";
  return ( $self->SUPER::_Init(@_));
}
# }}}

# {{{ sub LimitToQueue 

=head2 LimitToQueue

Takes a queue id (numerical) as its only argument. Makes sure that 
Scopes it pulls out apply to this queue (or another that you've selected with
another call to this method

=cut

sub LimitToQueue  {
   my $self = shift;
  my $queue = shift;
 
  $self->Limit (ENTRYAGGREGATOR => 'OR',
		FIELD => 'Queue',
		VALUE => "$queue")
      if defined $queue;
  
}
# }}}

# {{{ sub LimitToGlobal

=head2 LimitToGlobal

Makes sure that 
Scopes it pulls out apply to all queues (or another that you've selected with
another call to this method or LimitToQueue

=cut


sub LimitToGlobal  {
   my $self = shift;
 
  $self->Limit (ENTRYAGGREGATOR => 'OR',
		FIELD => 'Queue',
		VALUE => 0);
  
}
# }}}

# {{{ sub NewItem 
sub NewItem  {
  my $self = shift;
  
  return(new RT::Scrip($self->CurrentUser));
}
# }}}


1;

