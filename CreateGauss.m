function [y] = CreateGauss( height,xshift,sigma,plot )
%This function creates a Gaussian with the following characteristics
%height = the y-value of the Gaussian's maximum
%xshift = the x-value of the center of the Gaussian
%sigma  = half the width of the gaussian at one standard deviation
%plot = 1 means plot, otherwise it doesn't plot
%The Gaussian is a function and not evaluated at x
syms x y
y= height*exp(-(x-xshift).^2/(2*sigma^2));

if plot == 1
    ezplot(y);
end

end

