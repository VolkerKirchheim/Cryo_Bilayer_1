function [alignmentPixel,fitorder] = alignmentParameters(allProfilesF)
%UNTITLED6 Summary of this function goes here
%   Detailed explanation goes here
s=size(allProfilesF);
numberProfiles = s(1,1);
lengthProfiles = s(1,2);
x=[1:lengthProfiles];
alignmentPixel = ones(1,numberProfiles);
allProfilesFsmooth = smoothdata(allProfilesF,2,'Gaussian'); %smoothing all profiles for alignment
 for index = 1:numberProfiles
    TF = islocalmax(allProfilesFsmooth(index,:),'MinSeparation',15,'MaxNumExtrema',3);
    xTF = x(TF);
   
    alignmentPixel(1,index) = xTF(1,2);
 end
referencePixel = round(mean(alignmentPixel));
pixelshift = referencePixel - alignmentPixel;
%determining start profile as the one closest to mean
[~,b]=min(abs(pixelshift));
%fitting 2 troughs and peak
% startPixel =alignmentPixel(1,b);
fitorder = [b:numberProfiles];
fitorder2=[1:b-1];
fitorder = [fitorder fitorder2];
end

