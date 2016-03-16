%Okay, I'm going to play around with multiple lenses right now, but still
%keeping them distinct from each other to make sure that my focusing is
%working and all still. For the moment I don't think I'm going to randomize
%this. I will treat it as a test and hard code in distances. So this will
%be more like a script than a function.
clf;
width1 = 1.5;
width2 = 2.5;
xshift1 = -4;
xshift2 = 8;
yheight1 = -2;
yheight2 = -20;
trials = 100;
Gauss1 = CreateGauss(yheight1,xshift1,width1,0);
Gauss2 = CreateGauss(yheight2,xshift2,width2,0);
focal1 = focal_length(1.0001,1,Gauss1);
focal2 = focal_length(1.0001,1,Gauss2);
focal = focal1;
Gauss = Gauss1 + Gauss2;

width = abs((xshift2+width2)-(xshift1-width1));
if width == 0
    width = 2*width1;
end;

figure(3);
subplot(3,1,1);
hold on;
ezplot(Gauss,[-2*width,2*width]);
pos1 = BiLensTrial(1.0001,1,width,trials,0,Gauss,focal);
ycurr = get(gca,'YLim');
set(gca,'YLim',[min(yheight1,yheight2),ycurr(2)*1.5]);
yli = get(gca,'YLim');
xli = get(gca,'XLim');
hold off;

subplot(3,1,2);
hold on;
ezplot(Gauss1,[-2*width,2*width]);
BiLensTrial(1.0001,1,width,trials,0,Gauss1,focal);
set(gca,'YLim',yli,'XLim',xli);
hold off;

subplot(3,1,3);
hold on;
ezplot(Gauss2,[-2*width,2*width]);
BiLensTrial(1.0001,1,width,trials,0,Gauss2,focal);
set(gca,'YLim',yli,'XLim',xli);
hold off;

%I really need to determine how to find the maxiumum deflection for any
%lens so that I make sure that I'm not throwing out any data. Though
%truthfully the program will barf if that happens since it will try to
%index a non-existent index.

%My concern above is definitely what's going on here. I'm thinking that I
%should take the derivative, set it equal to zero, and find the max slope
%in order to then calculate what the maximum deflection is. I can then
%define how many bins I need based on that. Ugh. This will take a bit of
%thinking. Can Matlab solve equations?

%Okay, I'm having difficulty with this. I'm thinking that preallocating the
%size of count is actually not the best idea. The other way means that I am
%able to include every count. I just edited my BiLensTrial to function as
%OldPointTrial

%Ick, I can't use my new PointTrial anymore. Not only does it not work for
%focal distances that are too large (which cause ending x-values greater
%than my preallocated count size), but shifting the lens to the left or
%right causes this same problem. In fact, for some reason shifting the lens
%doesn't preserve the distribution or sharp peak at the minimum. I don't
%know why. :(

%Yeahhh, I think I might have discovered why I am having some issues. For
%some reason if I give focal_length the exact same lens, but one is just
%shifted to the left or right, it gives a different focal_length. Let me
%look into this. Okay, the issue is probably not focal_length but Rad_Curv

%Woops. In RadCurv I evaluate the derivatives at x=0, where the presumed
%maximum is located. Yeah, that's wrong. I need to change this. Fixed it!

%Hmmm, why is yheight a symbol?