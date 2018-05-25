% GRAD_MAG_IMAGE Compute a gradient magnitude image of the given image.
%
%   Y = GRAD_MAG_IMAGE(X) computes a gradient magnitude image of the image X.
%   Computation is based on the formula given in the lecture notes on image 
%   enhancement in spatial domain, pp.83.  The intensity values of the pixels 
%   that are out of the image boundary are treated as zeros.
%
%   REMINDER: The gradient magnitude image return should be in uint8 type.
%
function GMIm = grad_mag_image(Im)

assert_grayscale_image(Im);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% TODO 1: 
% Compute the gradient magnitude image.
% GMIm = ?;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
filter = [1,1,1;0,0,0;-1,-1,-1];

GMIm = abs(my_filter2(Im,filter)) + abs(my_filter2(Im, filter'));
if ~isa(GMIm,'uint8')
    GMIm = im2uint8(GMIm);
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

assert_uint8_image(GMIm);