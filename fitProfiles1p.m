function [fitresults,fitsigmas,fitconfidence,thicknesses] = fitProfiles1p(allProfilesF,fitall)
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here
tic
s=size(allProfilesF);
numberProfiles = s(1,1);
lengthProfiles = s(1,2);
minStart= 9;
maxStart = lengthProfiles-9;
x=[1:lengthProfiles];
alignmentPixel = ones(1,numberProfiles);
allProfilesFsmooth = smoothdata(allProfilesF,2,'Gaussian');
%
referencePixel = round(lengthProfiles/2);
%
%fitting 2 troughs and peak
startPixel =referencePixel;
%
fitresults = zeros(numberProfiles,3);
fitsigmas = zeros(numberProfiles,3);
fitconfidence = zeros(numberProfiles,6);
%confidenceline = zeros(1,6);
thicknesses=-ones(numberProfiles,6);
%First fit averaged curve to get start values
%Max
options = fitoptions('gauss1');
avgProfile = mean(allProfilesF,1);
maxWindow = avgProfile(1,startPixel-8:startPixel+8);
xWindow = [startPixel-8:startPixel+8];
options.StartPoint = [1 startPixel 4];
options.Lower = [0 startPixel-5 1];
options.Upper = [100 startPixel+5 10];
gfit = fit(xWindow',maxWindow','gauss1',options);
startPixel = round(gfit.b1);
%1st Min
startPixelT1 = startPixel-10;
if startPixelT1 < minStart
    startPixelT1 = minStart;
end

minWindow = -avgProfile(1,startPixelT1-8:startPixelT1+8);
xWindow = [startPixelT1-8:startPixelT1+8];
options.StartPoint = [1 startPixelT1 4];
options.Lower = [0 startPixelT1-5 1];
options.Upper = [100 startPixelT1+5 10];
gfit = fit(xWindow',minWindow','gauss1',options);
startPixelT1a = round(gfit.b1);
%2nd Min
startPixelT2 = startPixel+10;
if startPixelT2 > maxStart
    startPixelT2 = maxStart;
end
minWindow = -avgProfile(1,startPixelT2-8:startPixelT2+8);
xWindow = [startPixelT2-8:startPixelT2+8];
options.StartPoint = [1 startPixelT2 4];
options.Lower = [0 startPixelT2-5 1];
options.Upper = [100 startPixelT2+5 10];
gfit = fit(xWindow',minWindow','gauss1',options);
startPixelT2a=round(gfit.b1);
parfor index = 1:numberProfiles
    confidenceline = -ones(1,6);
    resultline = -ones(1,3);
    sigmaline = -ones(1,3);
    thicknessline = -ones(1,6); %(dBL, errdBL,dL1, errdL1,  dL2, derrL2)
    options = fitoptions('gauss1');
    %fitting max
%     startPixel = alignmentPixel(1,profileindex);
    maxWindow = allProfilesF(index,startPixel-8:startPixel+8);
    xWindow = [startPixel-8:startPixel+8];
    options.StartPoint = [1 startPixel 4];
    options.Lower = [0 startPixel-5 1];
    options.Upper = [100 startPixel+5 10];
    gfit = fit(xWindow',maxWindow','gauss1',options);
    ci = confint(gfit,0.95);
    confidenceline(1,3) = ci(1,2);
    confidenceline(1,4) = ci(2,2);
    if isnan(gfit.b1)||isnan(ci(1,2))
        resultline(1,2) = -1;
    else
        resultline(1,2)=gfit.b1;
    end
    sigmaline(1,2)=gfit.c1;
%     newstartPixel = round(gfit.b1);
%     if abs(newstartPixel-startPixel)<=8
%         startPixel = newstartPixel;
%     end
    if fitall
        %fitting 1st min
        startPixelT1 = startPixelT1a;
        if startPixelT1 < minStart
            startPixelT1 = minStart;
        end

        minWindow = -allProfilesF(index,startPixelT1-8:startPixelT1+8);
        xWindow = [startPixelT1-8:startPixelT1+8];
        options.StartPoint = [1 startPixelT1 4];
        options.Lower = [0 startPixelT1-5 1];
        options.Upper = [100 startPixelT1+5 10];
        gfit = fit(xWindow',minWindow','gauss1',options);
        ci = confint(gfit,0.95);
        confidenceline(1,1) = ci(1,2);
        confidenceline(1,2) = ci(2,2);
        if isnan(gfit.b1)||isnan(ci(1,2))
            resultline(1,1)=-1;
        else
            resultline(1,1)=gfit.b1;
            if resultline(1,2) ~= -1
                thicknessline(1,3) = abs(resultline(1,2)-resultline(1,1));
                thicknessline(1,4) = abs(confidenceline(1,2)-confidenceline(1,1))+...
                    abs(confidenceline(1,4)-confidenceline(1,3));
            end
        end
        sigmaline(1,1)=gfit.c1;
            %fitting 2nd min
        startPixelT2 = startPixelT2a;
        if startPixelT2 > maxStart
            startPixelT2 = maxStart;
        end
        minWindow = -allProfilesF(index,startPixelT2-8:startPixelT2+8);
        xWindow = [startPixelT2-8:startPixelT2+8];
        options.StartPoint = [1 startPixelT2 4];
        options.Lower = [0 startPixelT2-5 1];
        options.Upper = [100 startPixelT2+5 10];
        gfit = fit(xWindow',minWindow','gauss1',options);
        ci = confint(gfit,0.95);
        confidenceline(1,5) = ci(1,2);
        confidenceline(1,6) = ci(2,2);
        if isnan(gfit.b1)||isnan(ci(1,2))
            resultline(1,3)=-1;
        else
           resultline(1,3)=gfit.b1;
        
            if resultline(1,1) ~= -1
               thicknessline(1,1) = abs(resultline(1,3)-resultline(1,1));
                thicknessline(1,2) = abs(confidenceline(1,2)-confidenceline(1,1))+...
                    abs(confidenceline(1,6)-confidenceline(1,5));
            end
            if resultline(1,2) ~= -1
                thicknessline(1,5) = abs(resultline(1,3)-resultline(1,2));
                thicknessline(1,6) = abs(confidenceline(1,6)-confidenceline(1,5))+...
                abs(confidenceline(1,4)-confidenceline(1,3));
            end
            
        end
        
        sigmaline(1,3)=gfit.c1;
    end
    fitresults(index,:)=resultline;
    fitsigmas(index,:) = sigmaline;
    fitconfidence(index,:) = confidenceline;
    thicknesses(index,:)=thicknessline;
end
toc
end

