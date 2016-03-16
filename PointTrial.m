function [ ] = PointTrial(nlens,nmed,height,xshift,sigma,width,trials,binres)
%Conducts a specified number of trials to determine the position of a ray
%of light at a random x-value input through a lens. The output is a plot of
%position versus intensity.
%nlens = the index of refraction of the lens
%nmed = the index of refraction of the medium
%height = the y-value of the Gaussian's maximum
%xshift = the x-value of the center of the Gaussian
%sigma  = half the width of the gaussian at one standard deviation
%width = how wide of a lens region you would like (arbitrary)
%binres = what increment of bins you would like. -2 corresponds to a
%spacing of 10^-2, etc

%%%For the moment I'm just going to worry about concave lenses so that I
%%%can check if my focal length function is working and just to make sure
%%%everything works. For this reason I only want to deal with inputs that
%%%have a negative height value.

%Let me create a Gaussian lens. Remember that I'm dealing with symbolic
%functions here (aka not evaluated at specific x values)
Gauss = CreateGauss(height,xshift,sigma,1);
%Now I want to find the derivative
dGauss = diff(Gauss);

%%%This is to find the focal length so that I can adjust the height I am
%%%dealing with to hopefully cause diffraction patterns. I don't
%%%necessarilly want this feature in the future.
yheight=focal_length(nlens,nmed,Gauss);

%If I create a vector for the counts with one bin per index, then I know
%how I can index in by finding the length, adding 1, dividing by two, and
%then adding it to whatever actual position I'm referrring to. For example,
%for -200 to 200, the index 2 would be at (401+1)/2+x where x is the actual
%number I'm looking for
count=zeros(1,(10^(-1*binres))*4*width+1);
%The length of count
scount = length(count);
for i = 1:trials
    position=RefracPos(nlens,nmed,yheight,width,Gauss,dGauss);
    %Let me round the position so that we can put the positions into bins.
    round(position*10^(-1*binres));
    rposition=round(position*10^(-1*binres))*10^binres;
    index = round(rposition*10^(-1*binres)+(scount-1)/2+1);
    count(index)=count(index)+1;
end
figure(3);
bar(-2*width:10^binres:2*width,count);

end

