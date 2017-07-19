 % read image
lena = imread('lena.jpg');
% convert it into double type
lena = double(lena);
% get the dimensions
height = size(lena, 1);
width  = size(lena, 2);
% output image
filtered_lena = zeros(size(lena));       
% kernel. 
F = [1 4 6 4 1; 4 16 24 16 4; 6 24 36 24 6; 4 16 24 16 4; 1 4 6 4 1]/256;
% compute the offset for the rows and the columns, where the original image 
% boundaries are to be ignored
row_o = floor(size(F,1)/2); 
col_o = floor(size(F,2)/2);
     
% loop through all the pixels of the filtered image that we need to set their value 
% (i.e. ignoring the pixels at the image boundaries)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%     DEFINE THE LIMITS FOR THE ROW (i) AND COLUMN (j) INDICES         %%
row_limit = width - row_o;        
col_limit = height - col_o;       
for i = (1+row_o) : row_limit
   for j = (1+col_o) : col_limit
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %%     FILL IN THE EXPRESSIONS                                  %%
        % Extract the relevant original-image values (to be stored in    %
        % tempLena) which will be multiplied by the filter values. In    %
        % order to do this, you need to fill in the expressions for the  % 
        % row and column limits of the values to be extracted from lena: %
        row_min = i - row_o;
        row_max = i + row_o;
        col_min = j - col_o;
        col_max = j + col_o;
        %%     END OF YOUR INPUT                                        %%
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        tempLena = double(lena(row_min : row_max, col_min : col_max));
        filtered_lena(i,j) = sum(sum(F .* tempLena));
   end
end

imshow(uint8(filtered_lena));
      