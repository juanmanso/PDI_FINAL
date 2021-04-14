close all;
clear;


addpath('../img');
addpath('./utils');

max_range = 255;
myBlue = [0, 0.447, 0.741];
myRed = [0.85, 0.325, 0.098];
myYellow = [0.929, 0.694, 0.125];
myGreen = [0, 0.5, 0];

%% Cargo las imágenes
name1 = 'odin';
name2 = 'shadowlands-dark';
name3 = 'totalRecall';

img1 = imread(['../img/' name1 '.jpeg']);
img2 = imread(['../img/' name2 '.png']);
img3 = imread(['../img/' name3 '.png']);
img1g = rgb2gray(img1);
img2g = rgb2gray(img2);
img3g = rgb2gray(img3);


%% Imagen de prueba
im = img3g;
eta = [0.5, 0.5, 0.5];
% eta2 = [0.4, 0.5, 0.1];
% eta = eta2;

figure
imshow(im)
title('Imagen Original')

figure
ho = histo(im);
stem(ho, 'markeredgecolor', 'b', 'color', myBlue);
grid minor
axis([0, 256]);
title('Histograma de la imagen original');

figure
cdfo = cdf(ho);
plot(cdfo, 'linewidth', 2);
grid on
axis([0, 256]);
title('Función de densidad acumulada para la imagen original');

close all;

%% Realizo ecualización del histograma
imeq = equalizer(im, max_range);

figure
imshow(imeq)
title('Imagen Ecualizada');

figure
he = histo(imeq);
stem(he, 'color', 'g', 'markeredgecolor', myGreen);
grid minor
axis([0, 256]);
title('Histograma de la imagen ecualizada');

figure
cdfe = cdf(he);
plot(cdfe, 'linewidth', 2, 'color', myGreen);
grid on
axis([0, 256]);
title('Función de densidad acumulada para la imagen ecualizada');

close all;

%% Aplico el metodo ACE
imace = ace(im, eta);

figure
imshow(imace)
title('Imagen mejorada con ACE');

figure
hace = histo(imace);
stem(hace, 'color', myRed, 'markeredgecolor', 'r');
grid minor
axis([0, 256]);
title('Histograma de la imagen mejorada con ACE');

figure
cdface = cdf(hace);
plot(cdface, 'color', myRed, 'linewidth', 2);
grid on
axis([0, 256]);
title('Función de densidad acumulada para la imagen ACE');

close all;

%% Resultados
sections = [85, 170];
dark = 1:sections(1); mid = (sections(1)+1):sections(2); bright = (sections(2)+1):length(ho);

figure
title('Histograma dividido en regiones');
hold on
bar(bright, ho(bright), 'b');
bar(mid, ho(mid), 'g');
bar(dark, ho(dark), 'r');
axis([0, 256]);
grid minor

figure
title('Comparación de histogramas');
subplot(313);
stem(hace, 'color', 'y', 'markeredgecolor', myYellow); legend('ACE'); grid minor;
axis([0, 256]);
subplot(312);
stem(he, 'color', myRed, 'markeredgecolor', 'r'); legend('HE'); grid minor;
axis([0, 256]);
subplot(311);
stem(ho, 'color', 'b', 'markeredgecolor', myBlue); legend('Original'); grid minor;
axis([0, 256]);

figure
title('Comparación de CDFs');
hold on
plot(cdfo, 'color', myGreen, 'linewidth', 2);
plot(cdfe, 'color', myRed, 'linewidth', 2);
plot(cdface, 'color', myYellow, 'linewidth', 2);
legend('Original', 'HE', 'ACE');
legend('location', 'southeast');
axis([0, 256]);
grid minor

figure
title('Comparación de CDFs con diferencial');
difovseq = cdfo-cdfe;
difovsace = cdfo-cdface;
hold on
stem(difovseq, 'color', myRed, 'markeredgecolor','r');
stem(difovsace, 'color', myYellow, 'markeredgecolor', 'y');
legend('HE', 'ACE');
% legend('location', 'southeast');
axis([0, 256]);
grid minor

figure
title('Comparación de imagenes');
subplot(313);
imshow(imace);
subplot(312);
imshow(imeq);
subplot(311);
imshow(im);


figure(10)
title('Comparación de histogramas (Original vs ACE)')
subplot(212)
stem(hace, 'color', myRed, 'markeredgecolor', 'r')
legend('ACE')
axis([0, 256])
subplot(211);
stem(ho, 'color', 'b', 'markeredgecolor', myBlue)
axis([0, 256])
legend('Original')

figure(11)
title('Comparación de CDFs');
hold on
plot(cdfo, 'color', myBlue, 'linewidth', 2);
plot(cdface, 'color', myRed, 'linewidth', 2);
legend('Original', 'ACE');
legend('location', 'southeast');
axis([0, 256]);
grid minor

figure
imshow(im)
figure
imshow(imace)
