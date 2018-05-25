% GEN_GAUSS_NOISE Generate additive Gaussian noise.
%
%   Y = GEN_GAUSS_NOISE(m,n,sigma) generates an additive Gaussian noise image of
%   size m-by-n with the standard deviation of the noise equals sigma.
%
function Noise = gen_gauss_noise(sizeX, sizeY, sigma)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% TODO 2:
% Generate white Gaussian noise with the given sigma.
%
% Noise = ?

%m = zeros(sizeX, sizeY);
%for i=1:sizeX*sizey
%    m(i)=sqrt(-2*log(rand()))*cos(2*pi*rand()) * sigma;
%end
%Noise = m;
mean = 0;
Noise = normrnd(mean, sigma, sizeX, sizeY);
Noise = double(Noise);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Ensure the noise is of double datatype.
assert_double_image(Noise);