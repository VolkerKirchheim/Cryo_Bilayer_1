function exceptions = analyzeResults(resultArray,confidenceMax)
%analyseResults checks if the fit results for the two minima are Nan or
%outside the confidenceLimits
exceptions = isnan(resultArray(:,1));
exceptions = exceptions | isnan(resultArray(:,3));
exceptions = exceptions | isnan(resultArray(:,4));
exceptions = exceptions | isnan(resultArray(:,6));
exceptions = exceptions | isnan(resultArray(:,7));
exceptions = exceptions | isnan(resultArray(:,8));
exceptions = exceptions | isnan(resultArray(:,11));
exceptions = exceptions | isnan(resultArray(:,12));
confidenceLimit1 = abs(resultArray(:,8)-resultArray(:,7));
exceptions = exceptions | (confidenceLimit1 > confidenceMax);
confidenceLimit2 = abs(resultArray(:,12)-resultArray(:,11));
exceptions = exceptions | (confidenceLimit2 > confidenceMax);
end