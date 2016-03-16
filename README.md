# ShadowBands

**Table of Contents**  
This is a list of all the working functions. Indents mean that the item serves as a subfunction for the function above it.
 
* PointTrial
 * CreateGauss
 * focal_length
 *  RadCurv
 * RefracPos
* CircleLens
* BiLensTrial
*  RefracPos

**Function Summary:**
 
 *CreateGauss*  
 Generates a Gaussian based on the normal equation for a Gaussian based on 
 user-specified height of the curve, shift along the x-axis, sigma (half the
 width of the Gaussian at one standard deviation). The final input specifies
 whether or not to plot the subsequent Gaussian.
 ----------------------------------------
 *CircleLens*  
 This was a test function to make sure that RadCurv and focal_length were
 working, and does not contribute to any trials. This creates part of a
 circular lens that only exists in the first two quadrants. Any part below
 the x-axis is cut off, allowing for portions of a circle. The user can
 input the desired radius and height of the lens, where the height is the
 y-value of the circle's maximum.
 ----------------------------------------
 *RadCurv*  
 This calculates the radius of curvature for a lens, requiring the lens'
 function as input. This must be a *symbolic function*. it takes the first
 and second derivative of the function, solves for the first max/min, and
 evaluates both derivatives at this x-value. This essentially finds where
 the peak of the lens is. The radius of curvature is then calculated
 according to the equation [abs(1+dy^2)^(1.5)]/[abs(d2y)]. This will only
 work for a lens with one peak because of the way that I made it search
 for the maxima/minima.
 ----------------------------------------
 *focal_length*  
 This uses the thin lens formula to calculate the focal length of a lens.
 I'm assuming that the minimum or maximum of the lens is the first surface
 the light hits, and that the second surface upon exiting the lens is
 completely flat. The radius of curvature of the lens is calculated using
 RadCurv, so this will only work for a simple lens with one peak.
 ----------------------------------------
 *RefracPos*  
 This generates a beam of light at a random x-value within + or - width, a
 user-specified value. The angle of incidence (the small angle approx is
 used) is found by plugging the x-value into the derivative. The index of
 refraction is found via Snells law. The final position is the initial
 position plus the height of the lens at that position times the angle upon
 exiting the lens (this last portion is the extra horizontal distance
 caused by the refraction). This assumes the lens' peak is on the first
 surface, and the second surface is flat. In addition, this assumes a simple
 lens with one peak.
 ----------------------------------------
 *PointTrial*  
 This function actually runs trials with a user specified lens and randomly
 generated light beams, tracking the final x-position and graphing frequency
 at each position after a user-specified number of trials. It creates a
 Gaussian lens with user-specified height, horizontal shift,
 and width. It then differentiates the lens for use later, and calculates
 the focal-length of the lens. Then I create an empty vector to input
 the counts at each x-value, whose length differs depending on the resolution
 (am I tracking counts per unit, per tenth, etc). RefracPos tells me the
 final position of the random beam of light through this lens, which is then
 rounded to whatever resolution I have specified (e.g. with a resolution of
 -1 the position 10.237 would be rounded to 10.2 and placed in that bin in
 the count vector). I do some calculations to find the corresponding bin
 index and add this "count" into the count vector. A bar graph is th
 created plotting the counts at each x-value.
 
```
 >>PointTrial(1.0001,1,-10,.5,2.5,10,100,0);
 Index of refraction of lens:    1.0001
 Index of refraction of air:     1
 Lens Height:                    -10
 Lens Horizontal Shift:          0.5
 Lens Width at 1 Sigma:          2.5
 Width of Test Region:           10
 Trials:                         100
 Count Bin Resolution:           10^0 (or each integer has a bin)
 ```
 ----------------------------------------
 *BiLens*  
 Creates two Gaussians with hard-coded values at the top of the script.
 After calculating each focal length a third lens is created from adding the
 first two lenses together. Gauss1 must be further to the left and Gauss2
 must be further to the right. The plotting width region is determined
 from the farthest left point of the first lens and farthest right point of
 the second lens. 3 subplots are created, one for a user-specified number of
 trials with the first lens, trials with the second lens, and trials with
 the superimposed lens at the first lens' focal length. These trials are
 run in BiLensTrial, the same as PointTrial but taking as input the
 pre-created lens instead of creating one from scratch. BiLensTrial also
 does not calculate the focal length.
 ----------------------------------------
 *BiLensTrial*  
 Exact same as PointTrial, except personalized for the BiLens script. This
 requires the lens function and characteristics as input, and thus does not
 create a Gaussian or calculate the focal length.
 

 **Overall Summary**  
 PointTrial and BiLens are the important functions here for testing. The
 first can be used to test different one-peak lenses in 1 dimension. It is
 pre-coded to locate the lens at the height of the lens' focal length, but
 this can be changed in the code if you want to. As is there should be a
 peak at x=0, which is more or less apparant depending on the bin resolution.
 I've found that for 100 trials, a binres of 0 works pretty well. Unfortunately
 the function takes about 22 seconds to run with larger trials like 1000.
 I tried to stream-line the function, which is why I have included a description
 for PointTrail here and not oldPointTrial (which was my not as stream-lined
 version). I was not able to increase the run speed though.
 
 BiLens was my initial attempts to play around with lenses with two peaks,
 which I created by superimposing two other lenses which I specified. I did
 this so that I would know the focal-lengths of each individual lens and could
 then run trials with the superposition at the focal lengths for each
 individual lens. The superposition did show peaks at the correct x-values
 for each individual lens at the appropriate focal-length.
