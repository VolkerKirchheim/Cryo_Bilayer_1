function [allProfiles,allProfilesF,croppedI] = extractRadialProfiles(cryoI,circleCenter,circleRadius,segmentLengthPx,profileLengthPx)
%extractRadialProfiles extracts intensity profiles along the radius from a
%grayscale image
%Profiles of length profileLength are extracted within a circle around circleCenter with radius
%circleRadius  (all lengths are in pixel)
%segmentLength is the size of the segment over which the bilayer profiles
%are averaged and one thickness value will be determined
% allProfiles:  raw profiles for each interval
% allProfilesF:  segment profiles (averaged over one segmentlength, rolling
% average)
% cropped image of vesicle
xC = circleCenter(1,1);
yC = circleCenter(1,2);
radius = circleRadius;
%
circumference = 2*pi*radius;
segmentN = floor(circumference/segmentLengthPx); % number of segments
segmentAngle = 2*pi/segmentN; %angle of one segment
intervalN = floor(segmentLengthPx);% number of pixels in one segment
intervalAngle = segmentAngle/intervalN; %number of angles in one segment
%
maxRadius = round(radius + 10);
minRadius = maxRadius - profileLengthPx;
if minRadius < 1
    minRadius = 1;
end
%
% Vesicle Box
%
xMin = floor(xC-maxRadius);
xMax = ceil(xC+maxRadius);
%boxL = 2*maxRadius;
yMin = floor(yC-maxRadius);
yMax = ceil(yC+maxRadius);
croppedI = cryoI(yMin:yMax,xMin:xMax);
%
profileN = maxRadius-minRadius+1;
allProfiles = zeros(segmentN*intervalN,profileN);
allProfilesF = allProfiles;
allProfilesTemp = zeros((segmentN+1)*intervalN,profileN);
%
%  extracting profiles
%
for index1 = 1:segmentN %number of segments along circumference
    for index2 = 1:intervalN % number of intervals within one segment
        angle = (index1-1)*segmentAngle + (index2-1)*intervalAngle;
        for p = 1:profileN
            x = round(xC + (minRadius+p-1) * sin(angle));
            y = round(yC - (minRadius+p-1) * cos(angle));
            allProfiles((index1-1)*intervalN+index2,p) = cryoI(y,x);
            allProfilesTemp((index1-1)*intervalN+index2,p) = cryoI(y,x);
        end
    end
end
allProfilesTemp(segmentN*intervalN+1:segmentN*intervalN+intervalN,:)=allProfiles(1:intervalN,:);
%rolling average
for index = 1: (segmentN*intervalN)
    allProfilesF(index,:) = sum(allProfilesTemp(index:index+(intervalN-1),:))/intervalN; %averaging over segmentlength
end
end

