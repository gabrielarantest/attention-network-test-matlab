%This script is an attempt to create a attentional network experiment
%@Author : Gabriel Tiraboschi

clc; %clears the command window
clear all; %clear all variables
close all; %close all images and opened windows

% Here we call some default settings for setting up Psychtoolbox
PsychDefaultSetup(2);
Screen('Preference', 'SkipSyncTests', 1 );



%CONSTANTS
ARROW_TAIL_WIDTH = 20;
SPACE_BETWEEN_STIMULI = 2; %in the current monitor this is a space of 0.1cm
FIXATION_ARMS_SIZE = 8;
DISTANCE_FROM_FIXATION = 40;%this corresponds to 1cm in the current monitor
TOTAL_NUMB_TRIALS = 96;
STIMULI_CONDITIONS = [1:12];
STIMULI_CONDITIONS_UPPER = [1:2:11];%this separates upper stimuli from lower
STIMULI_CONDITIONS_LOWER = [2:2:12];%this separates upper stimuli from lower
STIMULI_CONDITIONS_ODDS = [STIMULI_CONDITIONS_UPPER , STIMULI_CONDITIONS_LOWER];
%In the stimulis array we repeated the first 3 rows and repeat an
%additional one separating the odds from even numbers. That's because cues
%number 3 and 4 are spatial cues and those need to be valid. Therefore even
%numbers that are stimuli in the upper VF should be matched with spatial
%cue to the upper VF (number 3).
STIMULI_ARRAY = [repmat(STIMULI_CONDITIONS, 1, 3) , STIMULI_CONDITIONS_ODDS];
CUE_ARRAY = [zeros(1,12), ones(1,12),repmat(2,1,12),repmat(3,1,6),repmat(4,1,6)];
MAX_RT = 1.7; %Maximum reaction time
SECOND_SCREEN_TIME = 0.1; %total time of the second screen
THIRD_SCREEN_TIME = 0.4; %total time in secs of the third screen
black = [0 0 0];
white = [255 255 255];
red = [255 0 0];
blue = [0 0 255];

%{
A session consists of a 24-trial full-feedback practice block and three experimental 
blocks of trials with no feedback. Each experimental block consists of 96 trials 
(4 cue conditions x 2 target locations x 2 target directions x 3 flanker conditions x 2 repetitions).
%}

%Class Variables
%those vector are in the same sequence as they are in the final matrix
trialsResponse = nan(1,96); %creates a line of 96 zeros to hold participants response
trialsResponseTime = nan(1,96); %creates a line of 96 zeros to hold participants response
accuracy = nan(1,96); %creates a line of 96 zeros to hold participants response
FirstScreenTotalTime = nan (1,96); %creates a line of 96 zeros to hold participants response
SecondScreenTotalTime = nan (1,96); %creates a line of 96 zeros 
ThirdScreenTotalTime = nan (1,96); %creates a line of 96 zeros 
ForthScreenTotalTime = nan (1,96); %creates a line of 96 zeros 
FithtScreenTotalTime = nan (1,96); %creates a line of 96 zeros 
%{
Here we create a new multidimensional array that stores the data from the
experiment and the order of stimuli presentation and cue conditions
1. line is the stimuli condition (e.g. Congruent, facing right)
2. line is the cue conditions (e.g. no cue or double cue)
3. line is the participants' response
4. line is the participants' reaction time
5. line is the participants' accuracy
6. to 10. line are the time audit of the screens presented to participants
%}
matrix=[repmat(STIMULI_ARRAY,1,2); repmat(CUE_ARRAY,1,2); trialsResponse; ...
    trialsResponseTime; accuracy; FirstScreenTotalTime; SecondScreenTotalTime; ...
    ThirdScreenTotalTime; ForthScreenTotalTime; FithtScreenTotalTime]; %creates multidimensional array to store data
rng('shuffle')%seeds the random number generator based on the current time.
shufledMatrix = matrix(:, randperm(size(matrix,2)));%shufles ONLY the columns of the matrix


try
    numOfTrials = input ('Por favor digite o número de trials que deseja, o normal é 24 para treino: ');

    %initiates the Psychtoolbox 
    %screen, which provides the background for all your stimuli
    %the last number is the antialising
    [window, windowRect] = Screen('OpenWindow',0,white,[],[],[],[],8);
   
  
    
    %Return the width and height of a window or screen in units of pixels.
    % Get the centre coordinate of the window
    [xCenter, yCenter] = RectCenter(windowRect); 
    % Set up alpha-blending for smooth (anti-aliased) lines
    Screen('BlendFunction', window, 'GL_SRC_ALPHA', 'GL_ONE_MINUS_SRC_ALPHA');
    %makes sure that the Psychtoolbox window is prioritised
    Priority (MaxPriority(window)); 
    HideCursor();
    
    % Query the frame duration
    ifi = Screen('GetFlipInterval', window);
    
    %defines a code for left and right
    left = 0;
    right = 1;

    %The introduction screen
    [~,~,keyCode] = KbCheck;
    while keyCode(KbName('space'))== 0 %while space bar is not pressed...
        Imagem ('Tarefa.JPG', window);
        % Setup the text type for the window
  
        Screen('TextFont', window, 'Times New Roman');
        Screen('TextSize', window, 20);
        %Instructions
        DrawFormattedText...
        (window, ...
        ['Obrigado por participar deste experimento. \n'...
        'A figura abaixo ilustra a tarefa a ser realizada por você.\n '...
        'Preste muita atenção na instrução do experimentador e após'...
        ' a explicação, pressione espaço para prosseguir'],...
        'center', 100, black, 0, 0, 0, 2);
        % Draw text in the middle of the screen
        Screen ('Flip', window);
        pause; %stops until a key is pressed
        [~,~,keyCode] = KbCheck; %records a key stroke
    end;

    %This is the loop for the experiment
    for trialNum = 1:numOfTrials
    %%-------------------------------------------------------------------------    
        %%This is the first screen
        rng ('shuffle'); %shuffle the seed
        randomTime = randperm (1200,1); %generate a random number
        D1 = (randomTime+400)/1000;
        fixationCross (windowRect, window, FIXATION_ARMS_SIZE, 2, black);
        %draw a fixation cross(windowRect,screen,arm size, line width, color)
        Screen ('Flip', window);
        startTrialTime = GetSecs; %Gets the time of the starting trail
        WaitSecs (D1); %Total time of the fixation presentation
   
        firstScreenFinishTime = GetSecs; 
        %Gets the total exibithion time of the first screen
        firstScreenTotalTime = firstScreenFinishTime - startTrialTime; 
     
    %%-------------------------------------------------------------------------
        %%This is the second screen (CUE)
        %{
        returns the contidion of the cue
        %}
        condition = shufledMatrix(2,trialNum);
        %{
        conditon = 0 -> no cue
        conditon = 1 -> center cue
        conditon = 2 -> double cue
        conditon = 3 -> spatial cue up
        conditon = 4 -> spatial cue down
        %}
        cue (window, windowRect, black, condition, DISTANCE_FROM_FIXATION, ...
            xCenter, yCenter, FIXATION_ARMS_SIZE);
        Screen ('Flip', window);
        WaitSecs(SECOND_SCREEN_TIME); %100ms of cue presentation
        
        %Gets the total exibithion time of the second screen
        secondScreenFinishTime = GetSecs;
        secondScreenTotalTime = secondScreenFinishTime - firstScreenFinishTime;
        
    %%-------------------------------------------------------------------------
        %%This is the third screen
        %draw a fixation cross(windowRect,screen,arm size, line width, color)
        fixationCross (windowRect, window, FIXATION_ARMS_SIZE, 2, black);
        Screen ('Flip', window);
        WaitSecs (THIRD_SCREEN_TIME); %Total time of the fixation presentation
        
        %Gets the total exibithion time of the third screen
        thirdScreenFinishTime = GetSecs;
        thirdScreenTotalTime = thirdScreenFinishTime - secondScreenFinishTime; 
        
    %%-------------------------------------------------------------------------
        %%This is the fourth screen (Stimuli presentation)
        %{
        Stimuli conditions:
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

        %draw a fixation cross
        fixationCross (windowRect, window, FIXATION_ARMS_SIZE, 2, black);
        %defines the y position of the upper part of the screen
        yPosUp = yCenter-DISTANCE_FROM_FIXATION; 
        %defines the y position of the lower part of the screen
        yPosDown = yCenter+DISTANCE_FROM_FIXATION;
        %draws the tail
        tail = true;
        
        conditionCode = shufledMatrix(1,trialNum); %Gets a condition code
        %The condition code is inserted in the function below
        %The function returns stimuli and flanker variables
        [ head, stimuliSide, flankerSide, yPosition ] = ...
            StimuliCondition( conditionCode, yPosUp, yPosDown );
        
        %%Target Stimuli
            xPos = xCenter; 
        %The screen, xPosition, yPosition, Wich side is facing, color, head, tail
            Arrow(window, xPos, yPosition, stimuliSide, black, true,...
                tail, ARROW_TAIL_WIDTH);
        
        %The first two arrows
            for i = 1 : 2
                xPos = xCenter-(i*(ARROW_TAIL_WIDTH+SPACE_BETWEEN_STIMULI));
                %The screen, xPosition, yPosition, Wich side is facing, color, head, tail
                Arrow(window, xPos, yPosition, flankerSide, black, head, ...
                    tail, ARROW_TAIL_WIDTH);
            end

        %The last two arrows
            for i = 1 : 2
                xPos = xCenter+(i*(ARROW_TAIL_WIDTH+SPACE_BETWEEN_STIMULI));
                %The screen, xPosition, yPosition, Wich side is facing, color, head, tail
                Arrow(window, xPos, yPosition, flankerSide, black, head, ...
                    tail, ARROW_TAIL_WIDTH);
            end
        


        Screen ('Flip', window);
        
        onsetTime = GetSecs; %records the onset time of the stimuli
        
        while (GetSecs - onsetTime) < MAX_RT
           %Gets the mouse index to use in the Kbcheck function
           [mouseIndices, productNames, allInfo] = GetMouseIndices('slavePointer');
           %Waits and register mouse clicks
           [keyIsDown,secs,keyCode, deltaSecs]=KbCheck(mouseIndices);
           %set default values
           mouseResponse = 0;
           RT = 0;
           fbColor = red;%set the default feedback red
           if keyIsDown;
            %calculates the RT
            RT = GetSecs - onsetTime;
            %register the mouse response in the mouse response variable
            if find(keyCode) == 3;
                mouseResponse = 2;
            elseif find(keyCode) == 1;
                mouseResponse = 1;
            end;
            %records the button clicked (1-left/2-right)
            shufledMatrix(3,trialNum)= mouseResponse; 
            
            %records reaction time
            shufledMatrix(4,trialNum)= RT; 
            %This condition checks if the participant response is correct
            %if participant's response is correct
            if mouseResponse == stimuliSide+1;
                shufledMatrix(5,trialNum)= 1;
                fbColor = blue;%feedback blue for correct respose
            %if participant's response is incorrect
            elseif mouseResponse ~= stimuliSide+1;
                shufledMatrix(5,trialNum)= 0;
                fbColor = red;%feedback red for incorrect response
            end;
            break;
           end;

         end
        
        %Gets the total exibithion time of the forth screen
        forthScreenFinishTime = GetSecs;
        forthScreenTotalTime = forthScreenFinishTime - thirdScreenFinishTime; 

    %%-------------------------------------------------------------------------
        %%This is the fitht and final screen
        %draw a fixation cross
        fixationCross (windowRect, window, FIXATION_ARMS_SIZE, 2, fbColor);
        Screen ('Flip', window);
        %Calculates the remaining time i.e. the last screen total time
        finalScreenTime = 3.5-RT-D1;
        WaitSecs(finalScreenTime);
        
        %Gets the total exibithion time of the fitht screen
        fifhtScreenFinishTime = GetSecs;
        fifhtScreenTotalTime = fifhtScreenFinishTime - forthScreenFinishTime; 
        
        %Time Audit
        shufledMatrix(6,trialNum)= firstScreenTotalTime;
        shufledMatrix(7,trialNum)= secondScreenTotalTime;
        shufledMatrix(8,trialNum)= thirdScreenTotalTime;
        shufledMatrix(9,trialNum)= forthScreenTotalTime;
        shufledMatrix(10,trialNum)= fifhtScreenTotalTime;
        %restores the fixation color to black
        fbColor = black;
    end

    %Closing the experiment
    
    WaitSecs (1);
    CloseExperiment (window); %this function closes the experiment
catch
    sca; % Clear the screen
    psychrethrow(psychlasterror);%throws the last error
end;
