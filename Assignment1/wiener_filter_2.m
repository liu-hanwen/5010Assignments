% WIENER_FILTER_2 Filter a noisy image with Wiener filter, suppose we DO NOT know the power
% spectra of the noise and the undegraded image.
%
%   Y = WIENER_FILTER_2(X,H,K) filters a noisy image X with Wiener filter. H defines
%   the degradation function and K is a constant to approximate the ratio of the power
%   spectrum of the noise image to the power spectrum of the undegraded image.
%
function Im = wiener_filter_2(NoisyIm, H, K)

% Check if the noisy image is grayscale and of uint8 datatype.
assert_grayscale_image(NoisyIm);
assert_uint8_image(NoisyIm);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% TODO 5:
% Filter the noisy image with Wiener filter, suppose we do not know the power
% spectra of the noise (Sn) and the undegraded image (Sf).  We use a
% constant K to estimate the ratio of Sn to Sf.
%
% Im = ?

if isa(NoisyIm, 'uint8')
    NoisyIm = im2double(NoisyIm);
end

G = fft2(NoisyIm);
[x,y] = size(G);
Im = zeros(x,y);
for idx=1:x*y
    p = floor((idx-1)/y) + 1;
    q = mod((idx-1),y) + 1;
    Im(p,q) = ((1/H(p,q) * norm(H(p,q))^2 / (norm(H(p,q))^2 + K))) * G(p,q);
end

Im = ifft2(Im);
Im = im2uint8(Im);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Convert the image to uint8 datatype.
Im = uint8(Im);