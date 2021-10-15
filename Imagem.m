function [ ] = Imagem(fileName, window)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

% Here we load in an image from file. This one is a image of rabbits that
% is included with PTB
theImageLocation = [fileName];
theImage = imread(theImageLocation);

% Get the size of the image
[s1, s2, s3] = size(theImage);

% Make the image into a texture
imageTexture = Screen('MakeTexture', window, theImage);

% Draw the image to the screen, unless otherwise specified PTB will draw
% the texture full size in the center of the screen. We first draw the
% image in its correct orientation.
Screen('DrawTexture', window, imageTexture, [], [], 0);

end

