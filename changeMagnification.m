function resultArray = changeMagnification(resultArray,newMagnification)
%changeMagnification scales all thickness values in a result array
%   to a new magnification (Angstroem per pixel)
for index = 1: size(resultArray,2)
    oldMagnification = resultArray(1,index).magnification;
    scalingFactor = newMagnification/oldMagnification;
    resultArray(1,index).thicknesses = resultArray(1,index).thicknesses*scalingFactor;
    resultArray(1,index).thicknessDistrMean = resultArray(1,index).thicknessDistrMean*scalingFactor;
    resultArray(1,index).thicknessDistrErr = resultArray(1,index).thicknessDistrErr*scalingFactor;
    resultArray(1,index).histo(1,:) = resultArray(1,index).histo(1,:)*scalingFactor;
    resultArray(1,index).bestfit(1,:) = resultArray(1,index).bestfit(1,:)*scalingFactor;
end