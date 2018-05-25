% MEDIAN_FILTER Filters a noisy image with a median filter.
%
%   Y = MEDIAN_FILTER(X) filters a noisy image X with a median filter.
%   A 3-by-3 window is used in the filtering process.
%
function Im = median_filter(NoisyIm)

% Check if the noisy image is grayscale and of uint8 datatype.
assert_grayscale_image(NoisyIm);
assert_uint8_image(NoisyIm);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% TODO 4:
% Filter the noisy image with median filter.  Use a 3x3 window to
% filter the image.
%
Im = my_filter2(NoisyIm, 'median');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Rescale the grayscale values of the filtered image to 0-255 and convert
% the image to uint8 datatype.
Im = (Im-min(Im(:)))./(max(Im(:))-min(Im(:))).*255;
Im = uint8(Im);