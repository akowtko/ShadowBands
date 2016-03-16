function [ r ] = RadCurv(y)
%This will calculate the radius of curvature for a simple lens according to
%the radius of curavture equation on wikipedia. E.g. this cannot be a
%superposition of lenses. Since this is really more of a tester function,
%please make sure that if you are using a gaussian lens from CreateGauss,
%set xshift = 0 so that I know where the maximum value is to calculate the
%raidus of curvature.
% y = the symbolic function defining the simple lens

%Let me take the lens's first derivative
dy = diff(y);
%Now I will take the second derivative by differentiating the first deriv
d2y = diff(dy);

%I need to determine where the maximum/minimum of the lens is, so let me
%have MATLAB solve the first derivative
maxima = solve(dy);
%I want to evaluate the derivatives at x=maxima, where the presumed maximum is
%located
dy0 = double(subs(dy,maxima));
d2y0 = double(subs(d2y,maxima));

%Now to calculate the numerator and denominator of the radius of curvature
%function
num = abs(1+dy0^2)^(1.5);
den = abs(d2y0);
r = num/den;
end

