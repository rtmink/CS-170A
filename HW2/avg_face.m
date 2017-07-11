function [avg_img, U, singular_values] = avg_face(filenames, k, samplesize)

row = 64;
col = 64;

%----------------------------------------------------------------------------------
%        Useful functions for converting  images  <-->  vectors
%----------------------------------------------------------------------------------
%
%   These bitmap images are 64x64 matrices of uint8 (unsigned 8-bit) values;
%   we convert these to double values in order to permit arithmetic.
%
%   We also convert 64 x 64 image matrices to 64^2 x 1 vectors (using reshape())
%   so that we can derive eigenfaces using Matlab's SVD/matrix functions.
%
%----------------------------------------------------------------------------------

image_vector = @(Bitmap) double(reshape(Bitmap,1,row*col));

vector_image = @(Vec) reshape( uint8( min(max(Vec,0),255) ), row, col);

vector_render = @(Vec) imshow(vector_image(Vec));

%----------------------------------------------------------------------------------
%        Demo:  read in and show <samplesize> face images
%----------------------------------------------------------------------------------

F = zeros(samplesize,row*col); % the array of sample images (stored as vectors)

numfiles = size(filenames,1);
rp = randperm(numfiles);       %  random permutation of the list of image filenames

sample = rp(1:samplesize);     %  use the first <samplesize> images as our sample

for i = 1:samplesize
   Image_File = sprintf('%s/%s', filenames(sample(i)).folder, filenames(sample(i)).name);
   Face_Matrix = imresize(imread(Image_File), [64 54]);
   Face_Matrix = [zeros(row, 5) Face_Matrix zeros(row, 5)];
   
   F(i,:) = image_vector(Face_Matrix);  % the i-th row of F is the i-th image
end

%----------------------------------------------------------------------------------
%        fbar = the average face
%----------------------------------------------------------------------------------

fbar = sum(F,1)/samplesize;   % average of all rows in F

avg_img = fbar';

%----------------------------------------------------------------------------------
%        Subtract the average face from each face in F
%----------------------------------------------------------------------------------

for i = 1:samplesize
   F(i,:) = F(i,:) - fbar;
end

%----------------------------------------------------------------------------------
%       Obtain the eigenfaces U with PCA
%----------------------------------------------------------------------------------

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%  [U, S, V] = svds( cov(F), k);  %%%% expensive
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%  singular_values = diag(S);

% do these things more efficiently:

[U, singular_values] = more_efficient_pca( F, k );

end