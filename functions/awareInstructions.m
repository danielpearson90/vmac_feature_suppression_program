
function awareInstructions()

global bigMultiplier smallMultiplier
global centOrCents
global awareInstrPause


instructStr1 = ['The eye tracking task is now finished - it''s fine to take your chin out of the chin rest.\n\nDuring this task, the amount that you could win on each trial was determined by the colour of the coloured shape that appeared on that trial. When certain colours appeared in the display, you could win ', num2str(smallMultiplier), ' ', centOrCents, ', and when other colours appeared you could win ', num2str(bigMultiplier), ' points.'];
instructStr1 = [instructStr1, '\n\nIn the final phase we will test what you remember about the different colours of shapes.'];

show_Instructions(1, instructStr1, 12);

end


function show_Instructions(~, insStr, instrPause)

global MainWindow scr_centre black white gray

instrWin = Screen('OpenOffscreenWindow', MainWindow, black);
Screen('TextSize', instrWin, 34);
Screen('TextStyle', instrWin, 1);

[~, ~, instrBox] = DrawFormattedText(instrWin, insStr, 'left', 'center' , white, 60, [], [], 1.5);
instrBox_width = instrBox(3) - instrBox(1);
instrBox_height = instrBox(4) - instrBox(2);
textTop = 150;
destInstrBox = [scr_centre(1) - instrBox_width / 2   textTop   scr_centre(1) + instrBox_width / 2   textTop + instrBox_height];
Screen('DrawTexture', MainWindow, instrWin, instrBox, destInstrBox);

Screen('Flip', MainWindow, [], 1);

contButtonWidth = 1000;
contButtonHeight = 100;
contButtonTop = 880;

contButtonWin = Screen('OpenOffscreenWindow', MainWindow, gray, [0 0 contButtonWidth contButtonHeight]);
Screen('TextSize', contButtonWin, 28);
Screen('TextFont', contButtonWin, 'Arial');
DrawFormattedText(contButtonWin, 'Click here using the mouse to continue', 'center', 'center', white);

contButtonRect = [scr_centre(1) - contButtonWidth/2   contButtonTop  scr_centre(1) + contButtonWidth/2  contButtonTop + contButtonHeight];
Screen('DrawTexture', MainWindow, contButtonWin, [], contButtonRect);


WaitSecs(instrPause);

Screen('Flip', MainWindow);
ShowCursor('Arrow');


clickedContButton = 0;
while clickedContButton == 0
    [~, x, y, ~] = GetClicks(MainWindow, 0);

    if x > contButtonRect(1) && x < contButtonRect(3) && y > contButtonRect(2) && y < contButtonRect(4)
        clickedContButton = 1;
    end

end


Screen('Close', instrWin);
Screen('Close', contButtonWin);

end