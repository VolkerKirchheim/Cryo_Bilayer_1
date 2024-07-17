function createMathematicaFolder(filepath,resultfolder,index,invert)
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here
cryoAnalyzer = 'C:\Users\Volker Kiessling\Dropbox\LAB\Cryo Analyzer\Analysis\cryoAnalyzer-v6.5.1-master.nb';
mxCombine = 'C:\Users\Volker Kiessling\Dropbox\LAB\Cryo Analyzer\Analysis\mxCombine-v2.2-master.nb';
%
%
[~, name, ext] = fileparts(filepath);
indexString = sprintf('%03d',index);
resultfolder = [resultfolder filesep name];
mkdir(char(resultfolder));
%
% copy Mathematica notebooks
%
cryoAnalyzerNew = char([resultfolder filesep 'cryoAnalyzer-v6.5.1-' indexString '.nb']);
%mxCombineNew = char([resultfolder filesep 'mxCombine-v2.2-' indexString '.nb']);
copyfile(cryoAnalyzer, cryoAnalyzerNew);
%copyfile(mxCombine, mxCombineNew);
%
% EM image file
 switch ext
     case '.tiff'
         newpath = char([resultfolder filesep name ext]);
         copyfile(filepath, newpath);
     case '.mrc'
         newpath = char([resultfolder filesep name '.tiff']);
        [m, ~]=ReadMRC(filepath,1,1);
        if invert
            m = -m;
        end
        saveTIFF32(newpath,m);
 end
 
end

