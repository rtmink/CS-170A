function IMG = photoshop_detector(filename)
	I = imread(filename);
	m = size(I,1);
	n = size(I,2);

	RI = reshape(I, m*n, 3);
	[U S V] = svd(cov(double(RI)));

	IMG = reshape(uint8(double(RI) * U(:,2)), m, n);
end