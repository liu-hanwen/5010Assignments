% connected_component.m contains the implementation of the main routine for Question 1 in Assignment 2. 
% This function search for all connected component on the input image. It should output the total number of
% connected components, number of pixels in each connected component and
% display the largest connected component. Note that you are not allow to
% use the bwlabel/bwlabeln/bwconncomp matlab built-in function in this
% question.

function connected_component()
    %Read the input image and convert it to binary image (0,1)
    IM = imread('cc_image.jpg');
    BW = im2bw(IM);
    %BW = [
    %    1,1,0,0;
    %    1,0,0,0;
    %    0,0,0,1;
    %    0,0,1,1]
    
    [x,y] = size(BW);
    mark = zeros(size(BW));
    
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
	% TODO_1: Search for all connected components with connectivity equals
	% to 8 and output the result to the command window in following format:
    disp('There are total {number of regions} region(s) :');
    % Region 1, no. of pixels = {number of pixels}
    % Region 2, no. of pixels = {number of pixels}
    % ...
    index = 0;
    counter = [];
    i = 0;
    j = 0;
    for i=1:x
        for j=1:y
            if mark(i,j)~=0
                continue;
            end
           
            if BW(i,j)==1
                index = index+1;
                mark(i,j) = index;
                counter = [counter,1];
                stk_x = [i];
                stk_y = [j];
                
                while size(stk_x)>0
                    %disp('==================');
                    %fprintf("(%d,%d)\n",stk_x,stk_y);
                    
                    % pop a center from stack
                    ii = stk_x(1);
                    jj = stk_y(1);
                    
                    % rebuild stacks
                    stk_x = stk_x(2:end);
                    stk_y = stk_y(2:end);
                    
                    % seaech 8 neighber pixels
                    % mark 1-pixel with index and push into stack
                    % mark 0-pixel with -1
                    % counter+=1
                    for iii = ii-1:ii+1
                        for jjj = jj-1:jj+1
                            % ignore the center point
                            if iii==ii && jjj==jj
                                continue
                            end
                            % TRY is to check if out of bounder
                            try
                                if mark(iii,jjj)==0
                                    if BW(iii,jjj)==1
                                        stk_x = [iii,stk_x];
                                        stk_y = [jjj,stk_y];
                                        mark(iii,jjj) = index;
                                        counter(index) = counter(index)+1;
                                    else
                                        mark(iii,jjj) = -1;
                                    end
                                end
                            end
                        end
                    end
                end
            else
                mark(i,j) = -1;
            end
        end
    end
    
    %mark
    %counter
    for temp=1:index    
        fprintf("Region %d, no. of pixels = {%d}\n", temp, counter(temp));
    end
                    
                
	
	%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
	% TODO_2: Find the largest connected component in binary format (0,1).
	L_CC = zeros(size(mark));
    [max_count,max_index] = max(counter);
    for i=1:x
        for j=1:y
            if mark(i,j)==max_index
                L_CC(i,j) = 1;
            end
        end
    end
    
    
	%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    figure;
    subplot(1,2,1);imshow(BW);title('Input image');
    subplot(1,2,2);imshow(L_CC);title('Largest connected component');
    
end

