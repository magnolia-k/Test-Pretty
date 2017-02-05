package Test::Pretty;
use 5.008001;
use strict;
use warnings;

our $VERSION = "0.40";

require Test::Builder;

if (Test::Builder->VERSION > 1.3) {
    if (!$ENV{HARNESS_ACTIVE} || $ENV{PERL_TEST_PRETTY_ENABLED}) {

        my $builder = Test::Builder->new();
        my $hub = $builder->{Stack}->top;

        require Test2::Formatter::Pretty;
        my $formatter = Test2::Formatter::Pretty->new();
        $formatter->encoding(Term::Encoding::term_encoding());
        $hub->format($formatter);
    } else {
        # do nothing ....not pretty.
    }

} else {

    # In an environment where Test2 is not loaded, use the original Test::Pretty.
    require Test::Pretty::Compat;
}

1;

__END__

=pod

=encoding utf8

=for stopwords cho45++

=head1 NAME

Test::Pretty - Smile Precure!

=head1 SYNOPSIS

  use Test::Pretty;

=head1 DESCRIPTION

Test::Pretty is a prettifier for Test::More.

When you are writing a test case such as following:

    use strict;
    use warnings;
    use utf8;
    use Test::More;

    subtest 'MessageFilter' => sub {
        my $filter = MessageFilter->new('foo');

        subtest 'should detect message with NG word' => sub {
            ok($filter->detect('hello from foo'));
        };
        subtest 'should not detect message without NG word' => sub {
            ok(!$filter->detect('hello world!'));
        };
    };

    done_testing;

This code outputs following result:

=begin html

<div><img src="https://raw.github.com/tokuhirom/Test-Pretty/master/img/more.png"></div>

=end html

No, it's not readable. Test::Pretty makes this result to pretty.

You can enable Test::Pretty by

    use Test::Pretty;

Or just add following option to perl interpreter.
    
    -MTest::Pretty

After this, you can get a following pretty output.

=begin html

<div><img src="https://raw.github.com/tokuhirom/Test-Pretty/master/img/pretty.png"></div>

=end html

And this module outputs TAP when $ENV{HARNESS_ACTIVE} is true or under the win32.

=head1 AUTHOR

Tokuhiro Matsuno E<lt>tokuhirom AAJKLFJEF@ GMAIL COME<gt>

=head1 THANKS TO

Some code was taken from L<Test::Name::FromLine>, thanks cho45++

=head1 SEE ALSO

L<Acme::PrettyCure>

=head1 LICENSE

Copyright (C) Tokuhiro Matsuno

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=cut
