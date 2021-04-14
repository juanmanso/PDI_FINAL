% El eta define el modo de operacion
% -> ace = img - eta (img - he)
% eta = 1 -> solo he
% eta = 0 -> solo img
function EQ = ace(img, eta)

	% Defino las regiones
	dark = 0:84; mid = 85:169; bright = 170:255;
	index_dark = img<85; index_mid = img>84 & img<170; index_bright = img>169;
	im_dark = img(index_dark); im_mid = img(index_mid); im_bright = img(index_bright);
	max_ranges = [dark(end)-dark(1) mid(end)-mid(1) bright(end)-bright(1)];
	ymin = [dark(1) mid(1) bright(1)];


	%%%%%%%%%%
	%% HE Dark
	im_region = im_dark;
	region = 1;
	wf = weighted_factor(histo(im_region, max_ranges(region)), dark, eta(region))
	cdf_region = cdf(histo(im_region));

	% Asigno a cada pixel su correspondiente punto en la CDF
	ev_cdf = cdf_region(im_region+1);	% +1 porque se indexa a partir de 1 y no 0

	% Ecualizo la region
	EQ_dark = uint8(ev_cdf * max_ranges(region) + ymin(region));

	% Asigno los pixels ecualizados a su posicion correcta en la imagen
	EQ(find(index_dark)) = EQ_dark;

	% Idem pero utilizando el peso wf para la ecualizada y la original
	aux = wf * EQ_dark;
	auxIm = (1-wf) * im_region;
	wEQ(find(index_dark)) = aux;
	wIm(find(index_dark)) = auxIm;

	%%%%%%%%%%
	%% HE Mid
	im_region = im_mid;
	region = 2;
	wf = weighted_factor(histo(im_region, [dark mid]), [dark mid], eta(region))
	cdf_region = cdf(histo(im_region));

	% Asigno a cada pixel su correspondiente punto en la CDF
	ev_cdf = cdf_region(im_region+1);	% +1 porque se indexa a partir de 1!

	% Ecualizo la region
	EQ_mid = uint8(ev_cdf * max_ranges(region) + ymin(region));

	% Asigno los pixels ecualizados a su posicion correcta en la imagen
	EQ(find(index_mid)) = EQ_mid;

	% Idem pero utilizando el peso wf para la ecualizada y la original
	aux = wf * EQ_mid;
	auxIm = (1-wf) * im_region;
	wEQ(find(index_mid)) = aux;
	wIm(find(index_mid)) = auxIm;

	%%%%%%%%%%
	%% HE Bright
	im_region = im_bright;
	region = 3;
	wf = weighted_factor(histo(im_region, [dark mid bright]), [dark mid bright], eta(region))
	cdf_region = cdf(histo(im_region));

	% Asigno a cada pixel su correspondiente punto en la CDF
	ev_cdf = cdf_region(im_region+1);	% +1 porque se indexa a partir de 1!

	% Ecualizo la region
	EQ_bright = uint8(ev_cdf * max_ranges(region) + ymin(region));

	% Asigno los pixels ecualizados a su posicion correcta en la imagen
	EQ(find(index_bright)) = EQ_bright;

	% Idem pero utilizando el peso wf para la ecualizada y la original
	aux = wf * EQ_bright;
	auxIm = (1-wf) * im_region;
	wEQ(find(index_bright)) = aux;
	wIm(find(index_bright)) = auxIm;


	%%%%%%%%%%
	%% Convierto el arreglo de pixels en una imagen
	EQ = reshape(wIm + wEQ, size(img));

end
