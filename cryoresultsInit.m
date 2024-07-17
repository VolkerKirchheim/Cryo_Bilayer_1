function cryoresultstr = cryoresultsInit(mode,imagepath)
%UNTITLED8 Summary of this function goes here
%   Detailed explanation goes here
cryoresultstr.mode = mode;
cryoresultstr.status =0;
cryoresultstr.tag = 0;
cryoresultstr.imagepath =char(imagepath)
cryoresultstr.magnification = 1;
cryoresultstr.vesicleposition = [0,0,0];
cryoresultstr.vesicleimage = [];
cryoresultstr.profilevariables = [];  %[segmentA, segmentPx, profilelengthA, profilelengthPx, Nprofiles]
cryoresultstr.alignmentPixel = [];  %max position along radial profile of original ROI
cryoresultstr.allprofiles = [];
cryoresultstr.allprofilesF = [];
cryoresultstr.avgProfile = [];
cryoresultstr.vesicleCoMradius =0;
cryoresultstr.fitresults= [];
cryoresultstr.thicknesses =[];
cryoresultstr.exceptions = [];
cryoresultstr.thicknessDistrMean = 0;
cryoresultstr.thicknessDistrErr = 0;
cryoresultstr.thicknessN =0;
cryoresultstr.histo = [];
cryoresultstr.bestfit = [];

end

