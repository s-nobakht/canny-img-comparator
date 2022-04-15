%{
--------------------------------------------
    Comparision Images with Canny Edge Detector
    Version 0.9
-------------------------------------------- 
%}

%% Clearing workspace
%--------------------------------------------
% close all open figures
close all;
% clear workspace and commands
clc;
clear;
%--------------------------------------------

%% Configurations
%--------------------------------------------
% input images' directory
inputDirectory  = 'samples';
% output images' directory
outputDirectory = 'output_1';
%--------------------------------------------
%% Main Code
% load input directory
% list all images having '.tif' extention
files = dir(strcat(inputDirectory,'/*.tif'));
for file = files'
    % load one image file
    imgFile = imread(strcat(inputDirectory,'/',file.name));
    % first loop for shifting lower treshold values
    for i=0.5:0.5:1
        % second loop for shifting higher treshold values
        for j=0:0.5:1
            % third loop for shifting lower treshold values
            for k=0.5:0.5:2.5
                % calculate edges with canny algorithm
                [edges_1,thresh_1] = canny(imgFile, i, j, k);                
                % generate output file name according to used parameters
                tempp2 = sprintf('%s/%s_%1.1f_%1.1f_%1.1f.tif',outputDirectory,'s01',i,j,k);                
                % save results
                imwrite(edges_1,tempp2,'tif');
            end
        end
    end
    fprintf('All Edge Samples of file "%s" Created.',file.name);       
end

