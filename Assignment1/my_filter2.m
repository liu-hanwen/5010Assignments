function res_img = my_filter2(varargin)

% If the input parameters are filter2(img, mask), then do the linear
% filtering
% Elseif the input parameters are filter2(img, 'median'), then do the
% median filtering

error(nargchk(2,2,nargin));

pic = varargin{1};
assert_uint8_image(pic);
pic = im2double(pic);

[x,y,z] = size(pic);
if(z>1)
    pic = rgb2gray(pic);
end
res_img = pic;


typ = 1;
masksize = 3;
if(strcmp(varargin{2}, 'median'))
    typ = 2;
else
    filter = varargin{2};
    [i,j] = size(filter);
    if(i~=j)
        error('Mask size should be i*i.')
    end
    masksize = i;
end
result = zeros(x-(2*floor(masksize/2)), y-(2*floor(masksize/2)));
[m,n] = size(result);
if typ==2
    result = [];
end
for idx=1:masksize^2
    dx = floor((idx-1)/masksize);
    dy = mod((idx-1),masksize);
    fx = dx+1;
    fy = dy+1;
    if(typ==1)
        result = result + (pic(1+dx:m+dx, 1+dy:n+dy) * filter(fx,fy));
    else
        result = [result;reshape(pic(1+dx:m+dx, 1+dy:n+dy), 1, m*n)];
    end
end
if typ==2
    result =reshape(median(result), m, n);
end
res_img(floor(masksize/2)+1:x-floor(masksize/2),floor(masksize/2)+1:y-floor(masksize/2)) = result;

% res_img = im2uint8(res_img);
            
