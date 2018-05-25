function atrim=atrimmed_mean_filter(NoisyIm,d)

%the mask size is set to be 3x3
masksize=1;

if((masksize*2+1)^2-d < 1)
    error('Parameter d is out of index with current masksize.');
end

NoisyIm = double(NoisyIm);
[sizeX, sizeY] = size(NoisyIm);

 % create a zero matrix with the same size of the input image
reformedimage(sizeX,sizeY)=zeros;

for i=1:sizeX;
    for j=1:sizeY;
        window=zeros(masksize*2+1, masksize*2+1);
        if ~((i+masksize<=sizeX) && (i-masksize>=1) && (j+masksize<=sizeY) && (j-masksize>=1))
            continue;
        end
        
        for m=-masksize:masksize;
            for n=-masksize:masksize;

% TODO:
% complete this for loop to apply the alpha trimmed mean filter
% pay attention to the range of the index
%
                                   
                window(2+m, 2+n) = NoisyIm(i+m, j+n);
                
            end
        end
        
        

       
      
% TODO:
% complete this for loop to apply the alpha trimmed mean filter
%
%
% reformedimage(i,j)= ?
        window = sort(reshape(window, 1, 9));
        reformedimage(i,j) = mean(window(d/2:d));
        
    end
end

atrim=uint8(reformedimage);