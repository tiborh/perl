#!/usr/bin/perl

print "This file has been created to see how pod documentation feature works.\n";
print "So try one of the pod converters to see more than this.\n";

=pod 

=head1 Test Heading

Normal text, that is, a prose paragraph. The default paragraph, when no modification is done.

This file has been converted from F<pod.pl>.

=head2 Lorem Ipsum

LoremX<Lorem> ipsum dolor sit amet, consectetur adipiscing elit. Cras rhoncus molestie vehicula. Sed in pharetra libero. Praesent porta, felis posuere tempus fringilla, neque arcu porttitor lectus, in rhoncus neque neque eu sem. Etiam lacinia consectetur ipsum, quis pretium erat convallis id. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Maecenas tortor libero, gravida vitae luctus et, feugiat sed ante. In hac habitasse platea dictumst. Quisque fringilla urna sit amet urna egestas fringilla. Donec vestibulum diam ac lacus scelerisque et rutrum mauris vehicula. Vestibulum eget sem eget felis molestie venenatis quis in sem. Donec faucibus congue justo et lobortis. Sed id malesuada lorem. Praesent tristique urna et elit convallis rhoncus.

=head2 Verbatim

    Verbatim paragraph starts with an indent.
    
    print "This file has been created to see how pod documentation feature works.\n";

=head2 Lists

The list environment is studied here.

=over 

=item 1

The first item

=item 2

The second item

=over

=item *

first sublist item

=item *

second sublist item

=back

=back

=over

=item first

The first definition list item

=item second

The second definition list item

=back

=head3 Third level

Third level heading also needed some testing.

=head1 Pod Sequences

Before reading the paragraph below, check L<Lorem Ipsum>. Another way of referencing: L<Lorem|Lorem Ipsum>.
And L<crontab(5)>, which only works for C<pod2man>.

I<Mauris> eu B<lorem orci>, et C<vestibulum> nisl. I<B<Mauris> at C<diam> massa>. Vestibulum consequat, libero quis sagittis pharetra, elit sem interdum urna, sed aliquet dui nulla quis urna. Nunc massa nisl, posuere in rhoncus eu, molestie vel mauris. Quisque tristique, sapien vitae adipiscing ultricies, nulla lectus gravida quam, in facilisis arcu eros vel quam. Sed nec venenatis sapien. In ut augue pellentesque est placerat placerat nec sit amet ligula. Proin luctus dolor eget arcu tincidunt in tincidunt augue viverra. Nulla facilisi. Praesent vitae gravida purus. Nunc sit amet ligula ligula. Aenean at orci sit amet nisl dictum placerat. Morbi nisl odio, tincidunt quis ornare sed, rutrum non nulla. Donec id ornare enim. Proin ac nulla a erat pellentesque tristique id quis sapien. Suspendisse augue felis, eleifend et dictum sed, tempor eget augue. Mauris odio diam, tristique vel bibendum consectetur, aliquet et orci. Nullam eget mi at nisl pellentesque vulputate eu in sapien.

S<This text was written with nonbreaking spaces. No matter how long the line is, it won't break. Wonderful, isn't it? Some more words to make it long enough for my screen to show the very long line. It will break, however, if you use a hyphen. only the space characters are non-breaking.>

=head2 Escape Sequences

The following can be escaped:

E<lt>

E<gt>

E<sol>

E<verbar>

iso8859-1 character codes e.g. E<169>

html character e.g. E<ntilde>

zero-width character e.g. in writing 

Z<>=head1 at the start of a line

C<< $a <=> $b >> not an escape sequence, but uses < and > inside a C.

=head1 HTML Table

=begin html

<table border="1">
<tr><th>head 1</th><th>head 2</th></tr>
<tr><td>cell 1</td><td>cell 2</td></tr>
<tr><td>cell 3</td><td>cell 4</td></tr>
</table>

=end html

=cut
