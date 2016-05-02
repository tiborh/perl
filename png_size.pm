package Png::Size v0.0.1{
    sub png_size
    {
	my $file = shift or return;
	my $buf;
	local(*IMG);		# make sure filehandler gets closed at the end
	open(IMG, $file) or return;
	binmode(IMG);
	read(IMG, $buf, 24);	# Read the first 8 + 4 + 4 + 4 + 4 bytes
	my ($hdr, $l, $ihdr, $w, $h) =
	    unpack("a8 N a4 N N", $buf);
	return unless
	    $hdr eq "\x89PNG\x0d\x0a\x1a\x0a" &&
	    $ihdr eq 'IHDR';
	return ($w, $h, 'PNG');
    }
}
package Xcf::Size v0.0.1{
    sub xcf_size {
	my $file = shift or return;
	my $buf;
	local(*IMG);
	open(IMG, $file) or return;
	binmode(IMG);
	read(IMG, $buf, 22);
	my ($hdr, $v, $w, $h) =
	    unpack("a9 Z5 N N", $buf);
	return unless ($hdr eq "gimp xcf ");
      SWITCH: {
	  $v eq 'file' and $v = 'XCF0', last SWITCH;
	  $v eq 'v001' and $v = 'XCF1', last SWITCH;
	  # Unknown version. $w and $h may be unreliable
	  return;
	}
	return ($w, $h, $v);
}
}
1;
