function f = ButterWorth(sze, cutoff, n)

% TODO:
% Complete the butterworth filter
%
%

x = sze(1);
y = sze(2);
f = zeros(x,y);
offsetX = floor(x/2);
offsetY = floor(y/2);

for idx=1:x*y
    p = floor((idx-1)/y) + 1;
    q = mod((idx-1),y) + 1;
    d = sqrt((p-offsetX)^2+(q-offsetY)^2);
    f(p,q) = 1/(1+(cutoff/d)^(2*n));
end