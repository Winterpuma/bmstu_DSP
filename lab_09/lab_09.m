function lab_09()
    I=double(imread('bimage2.bmp')) / 255;

    figure;
    imshow(I); 
    title('Source image');

    PSF=fspecial('motion', 55, 205);
    % PSF=fspecial('motion', 54, 65);
    [J1 P1]=deconvblind(I, PSF);
    figure;
    imshow(J1);
    title('Recovered image'); 
end