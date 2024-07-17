function [radiusCoM, XYCoM, XY] = calcCenterOfMass1(alignmentPixel,circleCenterPx,circleRadiusPx,segmentLengthPx,profileLengthPx)
%calcCenterOfMass calculates the center of mass radius of the analyzed
%liposomes based on the profile length settings and the already obtained
%alignment correction, i.e. the shift of the membrane from the assumed
%position.
%It also calculates updated contour coordinates
%Important:  All input coordinates are in pixels
sizeP = size(alignmentPixel,2);
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
xM = ones(1,sizeP);
yM = ones(1,sizeP) ;
for index = 1: sizeP
    angle = (index-1)*intervalAngle;
    xM(1,index) = xC + (minRadius+alignmentPixel(1,index)) * sin(angle);
    yM(1,index) = round(yC - (minRadius+alignmentPixel(1,index)) * cos(angle));
end
XY = [xM';yM'];
xCoM = mean(xM,2);
yCoM = mean(yM,2);
XYCoM = [xCoM, yCoM];
radiusCoM = sqrt(mean((xM-xCoM).^2+(yM-yCoM).^2,2));

