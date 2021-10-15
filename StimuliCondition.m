function [ heads, stimuliSide, flankerSide, yPosition ] = StimuliCondition( conditionCode, yPosUp, yPosDown )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
%{
Stimuli conditions Code:
1 = Neutral flankers, facing left in the higher part of the screen
2 = Neutral flankers, facing left in the lower part of the screen
3 = Neutral flankers, facing right in the higher part of the screen
4 = Neutral flankers, facing right in the lower part of the screen
5 = Congruent flankers, facing left in the higher part of the screen
6 = Congruent flankers, facing left in the lower part of the screen
7 = Congruent flankers, facing right in the higher part of the screen
8 = Congruent flankers, facing right in the lower part of the screen
9 = Incongruent flankers, facing left in the higher part of the screen
10 = Incongruent flankers, facing left in the lower part of the screen
11 = Incongruent flankers, facing right in the higher part of the screen
12 = Incongruent flankers, facing right in the lower part of the screen
%}

%defines a code for left and right
left = 0;
right = 1;

switch conditionCode
    case 1
        %Neutral flankers, facing left in the higher part of the screen
        heads = false;
        stimuliSide = left;
        flankerSide = left;
        yPosition = yPosUp;
    case 2
        %Neutral flankers, facing left in the lower part of the screen
        heads = false;
        stimuliSide = left;
        flankerSide = left;
        yPosition = yPosDown;
    case 3
        %Neutral flankers, facing right in the higher part of the screen
        heads = false;
        stimuliSide = right;
        flankerSide = right;
        yPosition = yPosUp;
    case 4
        %Neutral flankers, facing right in the lower part of the screen
        heads = false;
        stimuliSide = right;
        flankerSide = right;
        yPosition = yPosDown;
    case 5
        %Congruent flankers, facing left in the higher part of the screen
        heads = true;
        stimuliSide = left;
        flankerSide = left;
        yPosition = yPosUp;
    case 6
        %Congruent flankers, facing left in the lower part of the screen
        heads = true;
        stimuliSide = left;
        flankerSide = left;
        yPosition = yPosDown;
    case 7
        %Congruent flankers, facing right in the higher part of the screen
        heads = true;
        stimuliSide = right;
        flankerSide = right;
        yPosition = yPosUp;
    case 8
        %Congruent flankers, facing right in the lower part of the screen
        heads = true;
        stimuliSide = right;
        flankerSide = right;
        yPosition = yPosDown;
    case 9
        %Incongruent flankers, facing left in the higher part of the screen
        heads = true;
        stimuliSide = left;
        flankerSide = right;
        yPosition = yPosUp;
    case 10
        %Incongruent flankers, facing left in the lower part of the screen
        heads = true;
        stimuliSide = left;
        flankerSide = right;
        yPosition = yPosDown;
    case 11
        %Incongruent flankers, facing right in the higher part of the screen
        heads = true;
        stimuliSide = right;
        flankerSide = left;
        yPosition = yPosUp;
    case 12
        %Incongruent flankers, facing right in the lower part of the screen
        heads = true;
        stimuliSide = right;
        flankerSide = left;
        yPosition = yPosDown;
        
end

end

