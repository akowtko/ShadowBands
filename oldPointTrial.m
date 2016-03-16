function [ ] = oldPointTrial(nlens,nmed,height,xshift,sigma,width,trials)
%Conducts a specified number of trials to determine the position of a ray
%of light at a random x-value input through a lens. The output is a plot of
%position versus intensity.
%nlens = the index of refraction of the lens
%nmed = the index of refraction of the medium
%height = the y-value of the Gaussian's maximum
%xshift = the x-value of the center of the Gaussian
%sigma  = half the width of the gaussian at one standard deviation
%width = how wide of a lens region you would like (arbitrary)

%%%For the moment I'm just going to worry about concave lenses so that I
%%%can check if my focal length function is working and just to make sure
%%%everything works. For this reason I only want to deal with inputs that
%%%have a negative height value.

%Let me create a Gaussian lens. Remember that I'm dealing with symbolic
%functions here (aka not evaluated at specific x values)
figure(1);
Gauss = CreateGauss(height,xshift,sigma,0);
%Now I want to find the derivative
dGauss = diff(Gauss);

%%%This is to find the focal length so that I can adjust the height I am
%%%dealing with to hopefully cause diffraction patterns. I don't
%%%necessarilly want this feature in the future.
disp('About to calculate focal length');
yheight=focal_length(nlens,nmed,Gauss)
disp('Finished computing focal length');

%Creating empty vectors
positions=[];
count=[];
disp('Entering for loop');
for i = 1:trials
    position=RefracPos(nlens,nmed,yheight,width,Gauss,dGauss);
    %Let me round the position so that we can put the positions into bins.
    rposition=round(position);

    %If we've already had a hit at this position, add a tick mark
    if any(positions==rposition)
        cur_count = count(find(positions==rposition));
        count(find(positions==rposition)) = cur_count + 1;
    else
        count = [count,1];
        %Only add the position to the positions list if we've not seen it
        %before.
        positions=[positions,rposition];
    end   
end
disp('Exiting for loop')
figure(2);
bar(positions,count);

end

