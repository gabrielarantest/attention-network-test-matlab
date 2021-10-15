function [ ] = cue(screen1, rect, color, condition, DISTANCE_FROM_FIXATION, xCenter, yCenter, FIXATION_ARMS_SIZE)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

FONT_SIZE = 30;
AJUST = 3;
AJUST_LOWER = 3*AJUST;

%Formats the text
Screen('TextFont', screen1, 'Times');
Screen('TextSize', screen1, FONT_SIZE);
%Draws text to get measure 
[newX,~,~]=Screen('DrawText',screen1, '*', 0, 0, [255 255 255]);

%The fixation has a arm size of 8 pixels, witch corresponds to 0.5cm in the
%current display. Using the Times font in size 30 the cue have the same
%size as the fixation cross (0.5cm or 8 pixels). Therefore, we conclude
%that the size of the cue is 8 pixels (from corner to corner).


%No cue condition
if condition == 0
fixationCross (rect, screen1, FIXATION_ARMS_SIZE, 2, color);

% Center cue
elseif condition == 1
Screen('DrawText',screen1, '*', xCenter-(newX/2),... 
    (yCenter-AJUST_LOWER+AJUST), color);


elseif condition == 2
%Double cue condition
%draw a fixation cross
fixationCross (rect, screen1, FIXATION_ARMS_SIZE, 2, color);
% Draws the star in the upper part of the screen
Screen('DrawText',screen1, '*', xCenter-(newX/2),... 
    (yCenter - AJUST - DISTANCE_FROM_FIXATION), color);
% Draws the star in the botton part of the screen
Screen('DrawText',screen1, '*', xCenter-(newX/2),...
    (yCenter - AJUST_LOWER + DISTANCE_FROM_FIXATION), color);


elseif condition == 3
%Spatial cue up condition
%draw a fixation cross
fixationCross (rect, screen1, FIXATION_ARMS_SIZE, 2, color);
% Draws the star in the upper part of the screen
Screen('DrawText',screen1, '*', xCenter-(newX/2),... 
    (yCenter - AJUST - DISTANCE_FROM_FIXATION), color);

elseif condition == 4
%Spatial cue down condition
%draw a fixation cross
fixationCross (rect, screen1, FIXATION_ARMS_SIZE, 2, color);
% Draws the star in the botton part of the screen
Screen('DrawText',screen1, '*', xCenter-(newX/2),...
    (yCenter - AJUST_LOWER + DISTANCE_FROM_FIXATION), color);

end %end of the if condition


end

