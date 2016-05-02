package MyGd v0.0.1{
    use GD;
    sub define_colours {
	my $img = shift;
	# allocate some colors
	my $colours = {
	    white => $img->colorAllocate(255,255,255),
	    black => $img->colorAllocate(0,0,0), 
	    red => $img->colorAllocate(255,0,0),      
	    blue => $img->colorAllocate(0,0,255),
	    yellow => $img->colorAllocate(255, 255, 0),
	    green => $img->colorAllocate( 0, 255, 0),
	};
	return $colours;
    }
    sub send_to_file {
	my $img = shift;
	use File::Basename;
	my $bn = (split /\./,basename($0))[0];

	local *IMG;
	open(IMG, ">$bn.png");
	binmode IMG;
	print IMG $img->png;
	close IMG;
	return;
    }
}
1;
