function h = histo(img, hist_range)
	if nargin < 2
		hist_range=0:255;
	elseif length(hist_range(:)) == 1
		hist_range=0:hist_range;
	else
		hist_range=hist_range;
	end

	im = img(:);

	h = sum(im==hist_range)/length(im);
end
