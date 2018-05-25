% boundary_extraction.m contains the implementation of main routine for Question
% 1 in Assignment 2. This function uses erosion to obtain the boundary of different objects. 
% Note that you are not allowed to use the matlab built-in function such as
% imfilter, imerode or any third-party function in this question.

function boundary_extraction()

    % Read the input image and convert it to binary image
    IM = imread('image.jpg');
    img = im2bw(IM);
    % Display the input image
    figure;
    imshow(img);title('Input image');
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % TODO_1: Apply erosion on the image
    % img_erode = ??
    
    [x,y] = size(img);
    img_erode = zeros(x,y);
    mask = ones(3,3)
    for i=2:x-1
        for j=2:y-1
            if mask==img(i-1:i+1, j-1:j+1)
                img_erode(i,j) = 1;
            end
        end
    end
            
    imshow(img_erode);
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % TODO_1: Apply erosion on the image
    % img_boundary = ??
    img_boundary = img - img_erode;
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    % Display the input image
    figure;
    imshow(img_boundary);title('Boundary image');

end
    
    
    
    