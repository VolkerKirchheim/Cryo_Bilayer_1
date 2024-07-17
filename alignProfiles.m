function [allProfilesAligned,exceptions] = alignProfiles(allProfiles,alignmentPixel,fitorder)
%UNTITLED7 Summary of this function goes here
%   Detailed explanation goes here
%
s=size(allProfiles);
numberProfiles = s(1,1);
lengthProfiles = s(1,2);
x=[1:lengthProfiles];
%align all profiles
allProfilesAligned = zeros(numberProfiles,81);
startPixel =alignmentPixel(1,fitorder(1,1));
exceptions = zeros(1,numberProfiles,'logical');
lastAlignPixel = startPixel;
for index =1:numberProfiles
    profileIndex = fitorder(1,index);
    alignPixel = round(alignmentPixel(1,profileIndex));
    if abs(alignPixel-lastAlignPixel) >=10
        alignPixel = lastAlignPixel;
        exceptions(1,profileIndex)=true;
    else
        lastAlignPixel = alignPixel;
    end
    if alignPixel >= 41
        startPixel = alignPixel-40;
        startPixelA =1;
    else
        startPixel =1;
        startPixelA = 42-alignPixel;
    end
    if (lengthProfiles-alignPixel)>=40
        endPixel = alignPixel+40;
        endPixelA = 81;
    else
        endPixel = lengthProfiles;
        endPixelA = 41+(lengthProfiles-alignPixel);
    end
    allProfilesAligned(profileIndex,startPixelA:endPixelA)=allProfiles(profileIndex,startPixel:endPixel);
end
end

