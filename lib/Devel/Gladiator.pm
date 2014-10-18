use strict;
use warnings;
package Devel::Gladiator;
# ABSTRACT: Walk Perl's arena
# KEYWORDS: development debugging memory allocation usage leaks cycles arena

use base 'Exporter';

our %EXPORT_TAGS = ( 'all' => [ qw(
    walk_arena arena_ref_counts arena_table
) ] );

our @EXPORT_OK = ( @{ $EXPORT_TAGS{'all'} } );

sub arena_ref_counts {
    my $all = Devel::Gladiator::walk_arena();
    my %ct;
    foreach my $it (@$all) {
        $ct{ref $it}++;
        if (ref $it eq "REF") {
            $ct{"REF-" . ref $$it}++;
        }
    }
    $all = undef;
    return \%ct;
}

sub arena_table {
    my $ct = arena_ref_counts();
    my $ret;
    $ret .= "ARENA COUNTS:\n";
    foreach my $k (sort { $ct->{$b} <=> $ct->{$a} || $a cmp $b } keys %$ct) {
        $ret .= sprintf(" %4d $k\n", $ct->{$k});
    }
    return $ret;
}

use XSLoader;
XSLoader::load(
    __PACKAGE__,
    exists $Devel::Gladiator::{VERSION}
        ? ${ $Devel::Gladiator::{VERSION} }
        : (),
);

1;
__END__

=pod

=head1 SYNOPSIS

  use Devel::Gladiator qw(walk_arena arena_ref_counts arena_table);

  my $all = walk_arena();

  foreach my $sv ( @$all ) {
      warn "live object: $sv\n";
  }

  warn arena_table(); # prints counts keyed by class

  # how to spot new entries in the arena after running some code
  my %dump1 = map { ("$_" => $_) } walk_arena();
  # do something
  my %dump2 = map { $dump1{$_} ? () : ("$_" => $_) } walk_arena();
  use Devel::Peek; Dump \%dump2;

=head1 DESCRIPTION

L<Devel::Gladiator> iterates Perl's internal memory structures and can be used
to enumerate all the currently live SVs.

This can be used to hunt leaks and to profile memory usage.

=head1 EXPORTS

=head2 walk_arena

Returns an array reference containing all the live SVs. Note that this will
include a reference back to itself, so you should manually clear this array
(via C<@$arena = ()>) when you are done with it, if you don't want to create a
memory leak.

=head2 arena_ref_counts

=for stopwords reftype

Returns a hash keyed by class and reftype of all the live SVs.

This is a convenient way to find out how many objects of a given class exist at
a certain point.

=head2 arena_table

Formats a string table based on C<arena_ref_counts> suitable for printing.

=head1 SEE ALSO

=for :list
L<Become a hero plumber|http://blog.woobling.org/2009/05/become-hero-plumber.html>
L<Test::Memory::Cycle>
L<Devel::Cycle>
L<Devel::Refcount>
L<Devel::Leak>
L<Data::Structure::Util>

=cut
