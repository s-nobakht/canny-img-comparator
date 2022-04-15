%{
--------------------------------------------
    Comparision Images with Canny Edge Detector
    Version 3.0
-------------------------------------------- 
%}

%% Clearing workspace
%--------------------------------------------
close all;
clc;
clear;
%--------------------------------------------
%% Configurations
%--------------------------------------------
inputDirectory  = 'samples';
outputDirectory = 'output_1';
%--------------------------------------------
%% Main Code

%image1 = imresize( imread('sample_01.tif') , 0.3);
image1 = imread(strcat(inputDirectory,'/','sample_03.tif'));
image2 = imread(strcat(inputDirectory,'/','lena_eye.tif'));
%image2 = image1(200:end-100,200:end-200);

figure;
imshow(image1);
figure;
imshow(image2);


[edges_1,thresh_1] = canny(image1, 1, 0.5, 2.5);
[edges_2,thresh_2] = canny(image2, 1, 0.5, 2.5);

[rows1, cols1] = size(edges_1);
[rows2, cols2] = size(edges_2);
edgeImage_1 = figure;
imshow(edges_1);
edgeImage_2 = figure;
imshow(edges_2);


%{
rectangle('Position',pos,'EdgeColor','r','LineWidth',2);
rectangle('Position', [minRow(1,1) minCol(1,1) cols2 rows2] ); %// draw rectangle on image
%}


if(rows1<rows2 && cols1<cols2)     %search image inside another image    
    HausDists = zeros(rows2-rows1, cols2-cols1);
    for i=1:rows2-rows1
        for j=1:cols2-cols2
            [HausDists(i,j) ~] = HausdorffDist(edges_1, edges_2(i:i+rows1-1,j:j+cols1-1), 0, 'vis');
            %[hd D] = HausdorffDist(A,B,0,'vis');
            str = sprintf('i=%d ,j=%d, dist=%f',i,j,HausDists(i,j));
            disp(str);
        end
    end   
    
elseif(rows1>rows2 && cols1>cols2) %search image inside another image
    
    HausDists = zeros(rows1-rows2, cols1-cols2);
    for i=1:rows1-rows2
        for j=1:cols1-cols2
            [HausDists(i,j) ~] = HausdorffDist(edges_2, edges_1(i:i+rows2-1,j:j+cols2-1), 0, 'vis');
            %[hd D] = HausdorffDist(A,B,0,'vis');
            str = sprintf('i=%d ,j=%d, dist=%f',i,j,HausDists(i,j));
            disp(str);
        end
    end 
    
    %load('dists.mat');
    minMatrix = min(HausDists(:));
    [minRow,minCol] = find(HausDists==minMatrix);
    [noMinPoints ~] = size(minRow);
    figure(edgeImage_1);
    hold on;
    for i=1:2:noMinPoints
        for j=1:10:noMinPoints
            pos = [minRow(i,1) minCol(j,1)+20 cols2 rows2];
            %rectangle('Position',pos,'EdgeColor',[i*3/255 j*3/255 j*3/255],'LineWidth',1);
            rectangle('Position',pos,'EdgeColor','r','LineWidth',1);
        end
    end
    
    %{
    minMatrix = min(HausDists(:));
    [minRow,minCol] = find(HausDists==minMatrix);
    %}
elseif(cols1>cols2)
    A = edges_1;
    B = imresize(edges_2,cols1/cols2);
elseif(cols1<cols2)        
    A = imresize(edges_1,cols2/cols1);
    B = edges_2;
else
    A = edges_1;
    B = edges_2;
end

%save('dists','HausDists');        
disp('Program Finished !');

%mhd = ModHausdorffDist( B, A );

%[hd D] = HausdorffDist(A,B,0,'vis');

%disp('MHD : '+mhd);
%{
B = imresize(A,0.5);
figure;
imshow(A);
figure;
imshow(B);
[sFinal,thresh] = canny(A, 1, 0.5, 2.5);
figure;
imshow(sFinal);
%}