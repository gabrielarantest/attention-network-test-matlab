function[ ]= Arrow(screen1, xPosition, yPosition, sideFacing, color, head, ...
    tail, arrowTailWidth)
%TRIANGLE Summary this function draws a black triangle
%the sideFacing is either right or left, being 0 for left and 1 for right

 % create a triangle
    headCoord   = [ xPosition, yPosition ]; % coordinates of head
    width  = 10;     % width of arrow head
    height  = 5;     % height of arrow head
    % Cue to tell PTB that the polygon is convex (concave polygons require much
    % more processing)
    isConvex = 1;
%__________________________________________________________________________
if head == true
    % Draw the arrow head
    if sideFacing == 0 %left
        points = [ headCoord-[0, height]     % left corner
               headCoord+[0, height]         % right corner
               headCoord-[width, 0] ];      % vertex facing left
        Screen('FillPoly', screen1,color, points, isConvex);
    elseif sideFacing == 1 %right
        points = [ headCoord-[0, height]         % left corner
               headCoord+[0, height]         % right corner
               headCoord+[width, 0] ];      % vertex facing right
        Screen('FillPoly', screen1,color, points, isConvex);
    end;
end;

%___________________________________________________________________________________    
if tail == true
    %Draws the arrow tail (the line)
    arrowTailHeight = 2; %thickness of the arrow tail in pixels
 
    % Make a base Rect of 200 by 200 pixels. This is the rect which defines the
    % size of our square in pixels. Rects are rectangles, so the
    % sides do not have to be the same length. The coordinates define the top
    % left and bottom right coordinates of our rect [top-left-x top-left-y
    % bottom-right-x bottom-right-y]. The easiest thing to do is set the first
    % two coordinates to 0, then the last two numbers define the length of the
    % rect in X and Y. The next line of code then centers the rect on a
    % particular location of the screen.
    baseRect = [0 0 arrowTailWidth arrowTailHeight];
    % Center the rectangle on the centre of the screen using fractional pixel
    % values.
    if sideFacing == 0 %if the arrow is facing left
        centeredRect = CenterRectOnPointd(baseRect, xPosition, yPosition);
    elseif sideFacing == 1 %if the arrow is facing right
        centeredRect = CenterRectOnPointd(baseRect, xPosition, yPosition);
    end;

    % Draw the line
    Screen('FillRect', screen1, color,centeredRect);
end;

end

