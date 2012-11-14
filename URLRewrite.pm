package Plagger::Plugin::Filter::URLRewrite;
use strict;
use base qw( Plagger::Plugin );
use lib qw( /home/toshi/perl/lib );
use URLExpand;

sub register {
    my($self, $context) = @_;
    $context->register_hook(
        $self,
        'update.entry.fixup' => \&filter,
    );
}

sub filter {
    my($self, $context, $args) = @_;

    # RSS 2.0 SmartFeed
    my $entry = $args->{entry};
    my $org_url = $entry->permalink;
    my $expand_url = URLExpand->expand($org_url);
    $entry->permalink( $expand_url );
    $context->log(info => "Permalink rewritten to " . $entry->permalink);
}

1;

__END__

=head1 NAME

Plagger::Plugin::Filter::URLRewrite - Expand Short URL

=head1 SYNOPSIS

  - module: Filter::URLRewrite

=head1 DESCRIPTION

use URLExpand 
Rewrite shorten url or rssad url to original permalink

=head1 AUTHOR

Toshi Azwad


=head1 SEE ALSO

https://github.com/azwad/URLExpand

=cut
