function [refinedProfiles, positionsNew] = refineProfiles(allProfiles)
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here
cryoProfilesImage = image(allProfiles,"CDataMapping",'scaled');
roi = drawfreehand;
wait(roi);
%
positions = roi.Position;
positionsRounded = round(positions);
positionsNew = removeRevMoveFromLineROI(positionsRounded);
refinedProfiles = shiftProfiles(allProfiles,positionsNew);

end