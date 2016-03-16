function [ f ] = focal_length( nlens,nmed,y)
%This is the thin lens formula to calculate the focal length f of a lens.
%For focusing I want a concave lens
%nlens  =   Index of refraction of the lens
%nmed   =   Index of refraction of the medium
%r1     =   Radius of curvature of the lens surface where the light falls
%r2     =   Radius of curvature of the second surface
%f      =   focal length

%For this example I am saying that the light falls directly onto the lens,
%and that the secondary surface is really just flat and doesn't diffract or
%anything, so the radius of curvature is infinity.
r2=inf;
r1=RadCurv(y);
%Focal length equation
f = 1/((nlens/nmed-1)*((1/r1)-(1/r2)));


end