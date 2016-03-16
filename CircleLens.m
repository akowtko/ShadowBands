function [y] = CircleLens( r,h )
%This will create a lens that is part of a circle and plot it. The output
%is the symbolic function y representing the circle
%r = the circle's radius
%h = this defines the height of the lens, how much will peak above the
%x-axis. It is measured from the x-axis to the top of the lens. The lens
%doesn't exist below the x-axis, so this determines the cut-off point

%This generates the y-values
syms y x
y=sqrt(r^2-x^2)+h;
ezplot(y);
end

