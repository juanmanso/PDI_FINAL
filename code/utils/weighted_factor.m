function wf = weighted_factor(h, region, eta)
	ymax = max(region);         % Máximo valor de luminancia de la región
	N = sum(h);                 % Cantidad de puntos
	m = mean(region.*h)*ymax/N; % Luminancia media de la región

	% Calculo del sigma maximo, suponiendo que se concentra todo en los extremos
	% -> max_sigma = (1/N) * N/2 * 2 * (ymax+m)*(ymax-m+1)/2;
	max_sigma = ymax/2;

	% Calculo la pseudo varianza
	sigm = (1/N) * sum(h .* abs(region-m));

	wf = eta * (1 - abs(2*sigm/max_sigma - 1));
end
