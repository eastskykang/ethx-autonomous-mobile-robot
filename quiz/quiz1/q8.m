 % read image and convert it to a double
lena=imread('lena.jpg'); 
lena = double(lena);
% ---- Filters ---------------------- 
% filter to detect horizontal edges
gx = [1;0;-1]./sqrt(2);
% filter to detect vertical edges
gy = [1 0 -1]./sqrt(2);
% smoothing filter
F = [1 4 6 4 1; 4 16 24 16 4; 6 24 36 24 6; 4 16 24 16 4; 1 4 6 4 1];
F = F./norm(F);
% use 'conv2' and the filters given above to detect the edges in lena
smooth_lena = conv2(lena, F, 'same');

% derivatives
vert_lena = conv2(smooth_lena, gx, 'same');
hor_lena = conv2(smooth_lena, gy, 'same');      

% final
final_lena = sqrt(vert_lena.^2 + hor_lena.^2);

figure(1)
subplot(2, 2, 1)
imshow(uint8(smooth_lena))
title('smoothed')
subplot(2, 2, 2)
imshow(uint8(vert_lena))
title('vertical edges')
subplot(2, 2, 3)
imshow(uint8(hor_lena))
title('horizontal edges')
subplot(2, 2, 4)
imshow(uint8(final_lena))
title('final edges')