function positions = removeRevMoveFromLineROI(positions)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
positions = round(positions);
yPosition = positions(:,2)';
yPositionShift = yPosition(1,2:end);
yPosition = yPosition(1,1:end-1);
yDif = (yPositionShift-yPosition); % negativ when line moves backwards
isRev = find(yDif < 0, 1);
if isempty(isRev)
    %positions = positions;
    return;
else
    rIndex = isRev(1,1);
    positions = [positions(1:rIndex-1,:); positions(rIndex+1:end,:,:)];
    positions=removeRevMoveFromLineROI(positions);
end
%
end