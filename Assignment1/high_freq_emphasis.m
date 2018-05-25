function FEIm=high_freq_emphasis(Im, a,b)

% TODO:
% Emphasis the high frequency components of the images in the frequency domain.
% You will use the Butterworth filter in the high_freq_emphasis function, 
% you need to build a Butterworth filter in ButterWorth.m.
% 
% e.g.:
% H=ButterWorth([m, n], 0.2, 1); 
% The size of ButterWorth filter equal to the size of input image, 
% The cutoff frequency is 0.2.
% The order is 1.
% 

if(a>1 || a<0 || b<=a)
    error('Parameters do not meet the reqirements.')
end

%if ~isa(Im, 'double')
%    Im = im2double(Im);
%end
Im = fftshift(fft2(Im));
[x,y] = size(Im);

FEIm = zeros(x,y);
H = ButterWorth([x,y],0.2,1);
for idx=1:x*y
    p = floor((idx-1)/y) + 1;
    q = mod((idx-1),y) + 1;
    FEIm(p,q) = a + (b * H(p,q) * Im(p,q));
end
FEIm = ifft2(ifftshift(FEIm));
%FEIm = im2uint8(FEIm);
FEIm = uint8(FEIm);

% output image, pay attention to the number type
