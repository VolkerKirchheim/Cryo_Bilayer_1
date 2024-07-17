function [lineXY, boxL] = calcRadialLineSegment(index,circleCenterPx,circleRadiusPx,segmentLengthPx,profileLengthPx)
%calcRadialLineSegment calculates coordinates of line segments that are
%used to extract intensity profiles
%It also calculates the coordinates of a bounding box around the vesicles
%Important:  All input coordinates are in pixels
xC = circleCenterPx(1,1);
yC = circleCenterPx(1,2);
radius = circleRadiusPx;
%
circumference = 2*pi*radius;
segmentN = floor(circumference/segmentLengthPx);
segmentAngle = 2*pi/segmentN;
intervalN = floor(segmentLengthPx);
intervalAngle = segmentAngle/intervalN;
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
boxL = xMax-xMin+1;
m= maxRadius;

angle = (index-1)*intervalAngle;
x1 = round(xC + (minRadius) * sin(angle));
y1 = round(yC - (minRadius) * cos(angle));
x2 = round(xC + (maxRadius) * sin(angle));
y2 = round(yC - (maxRadius) * cos(angle));
%
x3 = round(m + (minRadius) * sin(angle));
y3 = round(m - (minRadius) * cos(angle));
x4 = round(m + (maxRadius) * sin(angle));
y4 = round(m - (maxRadius) * cos(angle));
lineXY=[x1,y1;x2,y2;x3,y3;x4,y4];
end

