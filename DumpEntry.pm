package Plagger::Plugin::Publish::DumpEntry;
use strict;
use base qw( Plagger::Plugin );
use feature qw( say );
use Encode;
use Time::HiRes qw(sleep);
use YAML;
#binmode STDOUT, ":utf8";

sub register {
    my($self, $context) = @_;
    $context->register_hook(
        $self,
        'publish.entry' => \&publish_entry,
        'plugin.init'   => \&initialize,
    );
}

sub initialize {
    my($self, $context) = @_;
}

sub publish_entry {
		my($self, $context, $args) = @_;
		my $num = $self->conf->{num};
		if ($self->conf->{dumptxt}){
			open my $fh, '>>', $self->conf->{dumptxt};
      select($fh);
		}
		$context->log(info => "Dump");
		my $title = $args->{entry}->title_text;
	 	my $link  = $args->{entry}->link;
		my $permalink = $args->{entry}->permalink;
	 	my $date  = $args->{entry}->date;
		my $text = $args->{entry}->body;

		my $enc1 = Encode::Guess::guess_encoding($title,qw/euc-jp cp932/);
		print '$title is '.$enc1->name ."\n";
		utf8::is_utf8($title)?say '$title is Flagged':say '$title is NonFlagged';
#		print "$title\n";
		my $enc2 = Encode::Guess::guess_encoding($text,qw/euc-jp cp932/);
		print '$text is '.$enc2->name ."\n";
		utf8::is_utf8($text)?say '$text is Flagged':say '$text is NonFlagged';
#		print "text\n";↲

		encode_utf8($title);
		encode_utf8($text);
	
		print "title----------------------------------------------------------------------------------------\n";
		print $title ."\n";
	 	print "link-----------------------------------------------------------------------------------------\n";
		print $link ."\n";
	 	print "permalink-----------------------------------------------------------------------------------------\n";
		print $permalink ."\n";
	 	print "date--------------------------------------------------------------------------------------\n";
		print $date ."\n";
		print "body_text------------------------------------------------------------------------------------\n";
		print $text ."\n";
		print "=============================================================================================\n"; 
		sleep $num;

}

1;
__END__

=head1 NAME

Plagger::Plugin::Publish::DumpEntry

=head1 SYNOPSIS

  - module: Publish::DumpEntry

=head1 DESCRIPTION

This plugin for module test

=head1 CONFIG

=over 4

=head1 AUTHOR

toshi Azwad

=head1 SEE ALSO



=cut
