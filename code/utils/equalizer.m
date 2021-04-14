function EQ = equalizer(img, max_range)
	cdfo = cdf(histo(img, max_range));

	cdfmax = max(cdfo);
	cdfmin = min(cdfo);

	ev_cdf = cdfo(img+1);	% +1 porque se indexa a partir de 1!
	EQ = uint8((ev_cdf - cdfmin) * max_range(end) / (cdfmax - cdfmin));
	EQ = uint8(ev_cdf * 255);
end
