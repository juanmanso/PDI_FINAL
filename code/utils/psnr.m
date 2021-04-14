function val = psnr(orig, new)
	mse = (orig-new).^2;
	mse = sum(sum(mse))/rows(orig)/columns(orig);

	m = max(max(orig));

	val = 20*log10(m) - 10*log10(mse);
end
