function cryoResult = cryoResultInit(mode)
%cryoResultInit initializes the cryoResult structure
cryoResult.mode = mode;
cryoResult.status = 0;
cryoResult.tag = 0;
cryoResult.imagepath = '';
cryoResult.magnification = 1;
cryoResult.vesicleposition = [];
cryoResult.vesicleimage = [];
cryoResult.profilevariables = [];
cryoResult.allprofiles = [];
cryoResult.allprofilesF = [];
cryoResult.avgProfile = [];
cryoResult.vesicleCoMradius = [];
cryoResult.fitresults = [];
cryoResult.thicknesses = [];
cryoResult.exceptions = [];
cryoResult.thicknessDistrMean = 0;
cryoResult.thicknessDistrErr = 0;
cryoResult.thicknessN = 0;
cryoResult.histo = [];
cryoResult.bestfit = [];

end