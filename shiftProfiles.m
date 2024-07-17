function refinedProfiles = shiftProfiles(allProfiles,positionsNew)
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here
%
nProfiles = size(allProfiles,1);
profileLength = size(allProfiles,2);
%
refinedProfiles = zeros(nProfiles,profileLength);
referencePixel = round(profileLength/2);
lasty = referencePixel;
alignPositions = zeros(nProfiles,1);
posIndex = 1;
interpolCounter = 0;
for index = 1:nProfiles
    if positionsNew(posIndex,2) == index
        newy =positionsNew(posIndex,1);
        % interpolate previous points if necessary
        if interpolCounter > 0
            slope = (newy - lasty)/(interpolCounter+1);
            alignPositions(index-interpolCounter:index-1,1)=lasty+alignPositions(index-interpolCounter:index-1,1)*slope;
        end
        % current position  
        alignPositions(index,1) = positionsNew(posIndex,1);
        %
        posIndex = posIndex+1;
        lasty = newy;
        interpolCounter = 0;
    else
        interpolCounter = interpolCounter+1;
        alignPositions(index,1) = interpolCounter;
    end
end
% extrapolate last indices with last slope
if interpolCounter > 0
    alignPositions(nProfiles-interpolCounter:nProfiles,1)=lasty+alignPositions(nProfiles-interpolCounter:nProfiles,1)*slope;
end
alignPositions = round(alignPositions);
pixelShift = alignPositions - referencePixel;
%
for index = 1:nProfiles
    if pixelShift(index,1) < 0
        shift = abs(pixelShift(index,1));
        tempProfile = allProfiles(index,:);
        insert = ones(1,shift).*tempProfile(1,1);
        tempProfile = [insert tempProfile(1,1:end-shift)];
        refinedProfiles(index,:) = tempProfile;
    elseif pixelShift(index) >0
        shift = abs(pixelShift(index,1));
        tempProfile = allProfiles(index,:);
        insert = ones(1,shift).*tempProfile(1,end);
        tempProfile = [tempProfile(1,1+shift:end) insert];
        refinedProfiles(index,:) = tempProfile;
    else % no shift
        refinedProfiles(index,:) = allProfiles(index,:);
    end
end
% figure
imagesc(refinedProfiles)
end