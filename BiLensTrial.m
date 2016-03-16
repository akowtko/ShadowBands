function [positions ] = BiLensTrial(nlens,nmed,width,trials,binres,Gauss,yheight)
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


%Now I want to find the derivative
dGauss = diff(Gauss);

%Creating empty vectors
positions=[];
count=[];
for i = 1:trials
    position=RefracPos(nlens,nmed,yheight,width,Gauss,dGauss);
    %Let me round the position so that we can put the positions into bins.
    rposition=round(position*10^(-1*binres))*10^binres;
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
figure(3);
bar(positions,count);
set(gca,'XLim',[min(positions),max(positions)]);
set(gca,'YLim',[0,max(count)]);

end

