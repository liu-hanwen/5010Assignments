% SEGMENT_PANDA contains the implementation of the main routine for Assignment 2. 
% This routine reads a image, which contains three intensity classes.
% The routine employs the Expectation-maximization method to estimate the parameters
% of the three intensity classes with a mixture of three Gaussian distributions, and
% segment the image with minimum error thresholds.
%  
function segment_image() 

% Define convergence threshold.
threshold = 0.01;

% Read the panda image and convert the color image into grayscale image.
Im = imread('sunset.jpg');
Im = rgb2gray(Im);
% Build a histgoram of the image, it is for the sake of
% parameter estimations and visualization.
Hist = imhist(Im,256)';

%
% The Expectation-maximization algorithm.
%

% Initialize the paramters.
Weight = zeros(3,1);
Mu = zeros(3,1);
Sigma = zeros(3,1);
Weight(1) = 0.35;
Weight(2) = 0.50;
Weight(3) = 0.15;
Mu(1) = 5;
Mu(2) = 90;
Mu(3) = 230;
Sigma(1) = 1;
Sigma(2) = 10;
Sigma(3) = 20;

itn = 1;
while(1)

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
	% TODO_1: Estimate the expected posterior probabilities.
	
    [n,tmp] = size(Mu);
    pixel_depth = 2^8;
    p_xi = sum(normpdf(0:pixel_depth-1, Mu, Sigma).*Weight);
    p_n_xi = normpdf(0:pixel_depth-1, Mu, Sigma).*Weight ./ p_xi;

    
	%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
	%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
	% Allocate spaces for the parameters estimated.
	NewWeight = zeros(3,1);
	NewMu = zeros(3,1);
	NewSigma = zeros(3,1);
    
    % TODO_2: Estimate the parameters.

    n_pixel = sum(Hist);

    tmp = (p_n_xi.*Hist); % size = (3,256)
    sum_tmp = sum(tmp,2); % size = (3,1)
    
    NewMu = sum((tmp.*[0:255]), 2) ./ sum_tmp;
    NewSigma = sqrt(sum(tmp .* (([0:255] - NewMu).^2),2) ./ sum_tmp);
    NewWeight = sum_tmp ./ n_pixel;

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
	
    % Check if convergence is reached.
	DiffWeight = abs(NewWeight-Weight)./Weight;
	DiffMu = abs(NewMu-Mu)./Mu;
	DiffSigma = abs(NewSigma-Sigma)./Sigma;
	
	if (max(DiffWeight) < threshold) & (max(DiffMu) < threshold) & (max(DiffSigma) < threshold)
        break;
	end
	
	% Update the parameters.
	Weight = NewWeight;
	Mu = NewMu;
	Sigma = NewSigma;
    
    disp(['Iteration #' num2str(itn)]);
    disp([' Weight: ' num2str(Weight(1)) ' ' num2str(Weight(2)) ' ' num2str(Weight(3))]);
    disp([' Mu: ' num2str(Mu(1)) ' ' num2str(Mu(2)) ' ' num2str(Mu(3))]);
    disp([' Sigma: ' num2str(Sigma(1)) ' ' num2str(Sigma(2)) ' ' num2str(Sigma(3))]);
    itn = itn + 1;
    
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% TODO_3(a): Compute minimum error threshold between the first and the second
% Gaussian distributions.
%
% FirstThreshold = ?

pdf = normpdf([0:255], Mu, Sigma).*Weight;
thresholds = zeros(n,1);

curThreshold = 1;
nextThreshold = curThreshold + 1;
for i=1:256
    if pdf(curThreshold, i) < pdf(nextThreshold, i)
        thresholds(curThreshold) = i-1;
        if nextThreshold==n
            break
        else
            curThreshold = nextThreshold;
            nextThreshold = curThreshold + 1;
        end
    end
end
    
    
FirstThreshold = thresholds(1)
 
% TODO_3(b): Compute minimum error threshold between the second and the third
% Gaussian distributions.
%
% SecondThreshold = ?
SecondThreshold = thresholds(2)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Show the segmentation results.
figure;
subplot(2,3,1);imshow(Im);title('Sunset');
subplot(2,3,3);imshow(Im<=FirstThreshold);title('First Intensity Class');
subplot(2,3,4);imshow(Im>FirstThreshold & Im<SecondThreshold);title('Second Intensity Class');
subplot(2,3,5);imshow(Im>=SecondThreshold);title('Third Intensity Class');
Params = zeros(9,1);
Params(1) = Weight(1);
Params(2) = Mu(1);
Params(3) = Sigma(1);
Params(4) = Weight(2);
Params(5) = Mu(2);
Params(6) = Sigma(2);
Params(7) = Weight(3);
Params(8) = Mu(3);
Params(9) = Sigma(3);
subplot(2,3,2);ggg(Params,Hist);