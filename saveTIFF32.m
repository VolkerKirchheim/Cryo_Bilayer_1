function  m = saveTIFF32(filename,m)
%saveTIFF32 saves the matrix m (32-bit single) in a tiff file 
sizeM = size(m);
%
t = Tiff( filename,'w');
tagStruct.Compression = Tiff.Compression.None;
tagStruct.ImageWidth=sizeM(1,1);
tagStruct.ImageLength=sizeM(1,2);
tagStruct.BitsPerSample=32;
tagStruct.Photometric=Tiff.Photometric.MinIsBlack;
tagStruct.PlanarConfiguration=Tiff.PlanarConfiguration.Chunky;
tagStruct.SamplesPerPixel=1;
tagStruct.SampleFormat=Tiff.SampleFormat.IEEEFP;
setTag(t,tagStruct);
%
write(t,m);
close(t);
end

