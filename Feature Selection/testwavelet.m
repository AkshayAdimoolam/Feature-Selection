clc; 
clear all;
close all;

data;

[file path] = uigetfile('*.bmp;*.jpg','Pick an Image File');
if file==0
    warndlg('User Pressed Cancel');
else
    inp_im = imread(file);
    figure(1);
    imshow(inp_im);
    title('Input Image');
    
end


% % % % HSV Transformation

HSV = rgb2hsv(inp_im);

figure(2);
imshow(HSV);
title('HSV image');


H = HSV(:,:,1);
S = HSV(:,:,2);
V = HSV(:,:,3);


% % % % Apply wavelet transform for each level

[LL1 LH1 HL1 HH1] = dwt2(H,'haar');
[LL2 LH2 HL2 HH2] = dwt2(S,'haar');
[LL3 LH3 HL3 HH3] = dwt2(V,'haar');

dec1 = [LL1 LH1;HL1 HH1];
dec2 = [LL2 LH2;HL2 HH2];
dec3 = [LL3 LH3;HL3 HH3];

figure(3);
imshow(dec1,[]);
title('Wavelet Transform for H Component');
figure(4);
imshow(dec2,[]);
title('Wavelet Transform for S Component');
figure(5);
imshow(dec3,[]);
title('Wavelet Transform for V Component');

E1 = entropy(LL1);
E2 = entropy(LH1);
E3 = entropy(HL1);
E4 = entropy(HH1);

E5 = entropy(LL2);
E6 = entropy(LH2);
E7 = entropy(HL2);
E8 = entropy(HH2);

E9 = entropy(LL3);
E10 = entropy(LH3);
E11 = entropy(HL3);
E12 = entropy(HH3);

Eng_im = [E1 E2 E3 E4 E5 E6 E7 E8 E9 E10 E11 E12];

F_Query = [sum([E1 E2 E3 E4]) sum([E5 E6 E7 E8]) sum([E9 E10 E11 E12])];

fid = fopen('database.txt');
resultValues_Gc = [];      % Results matrix...
resultNames_Gc = {};
i = 1;                  % Indices...
j = 1;

while 1
    imagename = fgetl(fid);
    if ~ischar(imagename), break, end       % Meaning: End of File...
    

     database_image = imread(imagename);
     HSV_DB = rgb2hsv(database_image);
    h = HSV_DB(:,:,1);
    s = HSV_DB(:,:,2);
    v = HSV_DB(:,:,3);

    [ll1 lh1 hl1 hh1] = dwt2(h,'haar');
    [ll2 lh2 hl2 hh2] = dwt2(s,'haar');
    [ll3 lh3 hl3 hh3] = dwt2(v,'haar');

% % % % %     dec1 = [LL1 LH1;HL1 HH1];
% % % % %     dec2 = [LL2 LH2;HL2 HH2];
% % % % %     dec3 = [LL3 LH3;HL3 HH3];
% % % % % 
% % % % %     figure(3);
% % % % %     imshow(dec1,[]);
% % % % %     title('Wavelet Transform for H Component');
% % % % %     figure(4);
% % % % %     imshow(dec2,[]);
% % % % %     title('Wavelet Transform for S Component');
% % % % %     figure(5);
% % % % %     imshow(dec3,[]);
% % % % %     title('Wavelet Transform for V Component');

    E1 = entropy(ll1);
    E2 = entropy(lh1);
    E3 = entropy(hl1);
    E4 = entropy(hh1);

    E5 = entropy(ll2);
    E6 = entropy(lh2);
    E7 = entropy(hl2);
    E8 = entropy(hh2);

    E9 = entropy(ll3);
    E10 = entropy(lh3);
    E11 = entropy(hl3);
    E12 = entropy(hh3);

%     Eng_im = [E1 E2 E3 E4 E5 E6 E7 E8 E9 E10 E11 E12];

    F_data = [sum([E1 E2 E3 E4]) sum([E5 E6 E7 E8]) sum([E9 E10 E11 E12])];
     

     Dist1 = (sum(abs(F_Query -F_data)));




    resultValues_Gc(i) = Dist1;
       
    
       
    
    resultNames_Gc(j) = {imagename};
    i = i + 1;
    j = j + 1;
end
fclose(fid);

%%%%%%%%%%%%%%%% Sort the Results in Ascending order..............
[sortedValues1, index1] = sort(resultValues_Gc);     

name = resultNames_Gc;


for i = 1:10
            a = imread(cell2mat(name(index1(i))));
            
            
            
            if i==1
%             axes(handles.axes22);
            imshow(a);
            
            
            end
            if i==2
%             axes(handles.axes23);
            imshow(a);
            
            end
            if i==3
%             axes(handles.axes24);
            imshow(a);
            
            
            end
            if i==4
%             axes(handles.axes25);
            imshow(a);
            
            
            end
            if i==5
%             axes(handles.axes26);
            imshow(a);
            
           
            end
            if i==6
%             axes(handles.axes27);
            imshow(a);
            
           
            end
            if i==7
%             axes(handles.axes28);
            imshow(a);
            
            
            end
            if i==8
%             axes(handles.axes29);
            imshow(a);
            
            
            end
            if i==9
%             axes(handles.axes30);
            imshow(a);
           
            
            end
            if i==10
%             axes(handles.axes31);
            imshow(a);
            
            
            end
end      


