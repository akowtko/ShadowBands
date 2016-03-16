function [ position ] = RefracPos( nlens,nmed,yheight,width,lens,dlens)
%This function determines the x-value on the ground of a point source of
%light at a randomly chosen x-value through a Gaussian shaped crown
%glass lens.
%nlens = the index of refraction of the lens
%nmed = the index of refraction of the medium
%width = the width of the lens region. This is arbitrary. You probably want
%it to be greater than sigma so that you get the entire Gaussian for
%testing.
%yheight = height of the lens off the ground
%lens = the symbolic function for the lens
%dlens = the symbolic function for the derivative of the lens

%Generate an xin from a uniformly distributed pseudorandom number between
%0 and 1 multiplied by the width of the lens regioun to give a random
%x-starting value.
xin = -1.0*width + width*2*rand(1);
%Finding the angle of incidence relative to the normal of the surface. We
%are taking the small angle approximation that tan theta is approximately
%theta, so this function is really just retrieving the slope of the
%function at the xin.
incident = subs(dlens,xin);
%Finding the angle of refraction using the angle of incidence and Snell's
%Law
refraction = (nmed/nlens)*incident;
%Now to find where the light hits the ground. It comes in at some xin which
%can be positive or negative. Then after refraction it must travel the
%height of the lens at the location it hit the lens plus however high the
%lens was off the ground.

%remove the subs portion, the lens isn't really that thick. Also, add in
%the angle of incidence to the refraction-incident portion
position = xin+(subs(lens,xin)+yheight)*(refraction-incident);
end
