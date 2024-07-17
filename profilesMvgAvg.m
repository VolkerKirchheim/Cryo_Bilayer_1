function allProfilesF = profilesMvgAvg(allProfiles,segmentPx)
%UNTITLED5 Summary of this function goes here
%   Detailed explanation goes here
s=size(allProfiles);
numberofProfiles = s(1,1);
profileN = s(1,2);
allProfilesF = allProfiles;
allProfilesTemp = zeros(numberofProfiles+segmentPx,profileN);
allProfilesTemp(1:numberofProfiles,:)=allProfiles;
%
allProfilesTemp(numberofProfiles+1:numberofProfiles+segmentPx,:)=allProfiles(1:segmentPx,:);
%rolling average
for index = 1: numberofProfiles
    allProfilesF(index,:) = sum(allProfilesTemp(index:index+segmentPx-1,:))/segmentPx;
end
end

