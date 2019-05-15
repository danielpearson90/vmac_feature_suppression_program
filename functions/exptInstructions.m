
function exptInstructions

global MainWindow white
global bigMultiplier smallMultiplier
global centOrCents
global softTimeoutDuration
global trialCounter contingencyInformedVersion  omissionInformedVersion
global targetBalance



switch targetBalance
    case 1
        targetStr = 'DIAMOND';
        targetStr2 = 'diamond';
    case 2
        targetStr = 'CIRCLE';
        targetStr2 = 'circle';
    case 3
        targetStr = 'UNIQUE';
        targetStr2 = 'unique shape';
    case 4
        targetStr = 'CIRCLE OR DIAMOND';
        targetStr2 = 'circle or diamond';
end


if contingencyInformedVersion
    contingencyStr = '\n\nThe amount that is available for you to earn will depend on the coloured shape that is presented on the trial.';
else
    contingencyStr = '';
end

if omissionInformedVersion
    omissionStr = '\n\nIf you accidentally look at the coloured circle before you look at the diamond, you will receive no reward. So you should try to move your eyes straight to the diamond.';
else
    omissionStr = ['\n\nThe amount that you earn will also depend on how accurately you move your eyes to the ', targetStr2, '.'];
end

instructStr = {['The rest of this experiment is similar to the trials you have just completed. On each trial, you should move your eyes to the ', targetStr,' shape as quickly and directly as possible.'], ...
    ['From now on, you will be able to earn points for correct responses. On each trial you will earn either 0 points, ', num2str(smallMultiplier), ' ', centOrCents, ', or ', num2str(bigMultiplier), ...
    ' points. These points will be converted into a cash reward at the end of the experiment.', contingencyStr], ...
    ['If you take longer than ', num2str(round(softTimeoutDuration * 1000)), ' milliseconds to move your eyes to the ', targetStr2,', you will receive no points. So you will need to move your eyes quickly!', omissionStr], ...
    'After each trial you will be told how many points you won, and your total points earned so far in this session.'};


show_Instructions(1, instructStr{1});
show_Instructions(2, instructStr{2});
show_Instructions(3, instructStr{3});
show_Instructions(4, instructStr{4});

trialCounter = 0;

% for aa = randperm(4)
%     understanding_Test(aa, instructStr7, 1);
%     understanding_Test(aa, ['How much would you receive if you looked at the coloured circle before looking at the diamond on this trial?'], 2);
% end
% 
% TT = [5 6];
% 
% for bb = TT(randperm(2));
%     understanding_Test(bb, instructStr7, 1);
%     if bb == 5
%         instructStr8 = ['How much would you receive if you looked at the ' colourName(1,:) ' circle before looking at the diamond on this trial?'];
%         instructStr9 = ['How much would you receive if you looked at the ' colourName(2,:) ' circle before looking at the diamond on this trial?'];
%     else
%         instructStr8 = ['How much would you receive if you looked at the ' colourName(3,:) ' circle before looking at the diamond on this trial?'];
%         instructStr9 = ['How much would you receive if you looked at the ' colourName(4,:) ' circle before looking at the diamond on this trial?'];
%     end
%     understanding_Test(bb, instructStr8, 2);
%     understanding_Test(bb, instructStr9, 3);
% end

DrawFormattedText(MainWindow, 'Please tell the experimenter when you are ready to begin', 'center', 'center' , white);
DrawFormattedText(MainWindow, 'EXPERIMENTER: Press C to recalibrate, T to continue with test', 'center', 800, white);
Screen(MainWindow, 'Flip');

RestrictKeysForKbCheck([]); % Re-enable all keys


end


function show_Instructions(instrTrial, insStr)

global MainWindow scr_centre black white
global bigMultiplier smallMultiplier
global distract_col colourName circleRect
global contingencyInformedVersion

x = 600;
y = 600;

exImageRect = [scr_centre(1) - x/2    scr_centre(2)-50    scr_centre(1) + x/2   scr_centre(2) + y - 50];




instrWin = Screen('OpenOffscreenWindow', MainWindow, black);
Screen('TextSize', instrWin, 34);
Screen('TextStyle', instrWin, 1);

textColour = white;

[~, ny, instrBox] = DrawFormattedText(instrWin, insStr, 'left', 100 , textColour, 60, [], [], 1.5);
instrBox_width = instrBox(3) - instrBox(1);
instrBox_height = instrBox(4) - instrBox(2);
textTop = 150;
destInstrBox = [scr_centre(1) - instrBox_width / 2   textTop   scr_centre(1) + instrBox_width / 2   textTop + instrBox_height];

Screen('DrawTexture', MainWindow, instrWin, instrBox, destInstrBox);


if contingencyInformedVersion
    
    if instrTrial == 2
        circSize = 150;
        circleRect(1,:) = [scr_centre(1) - instrBox_width/2 scr_centre(2) scr_centre(1) - instrBox_width/2 + circSize scr_centre(2) + circSize];
        %circleRect(2,:) = [scr_centre(1) - instrBox_width/2 + circSize + 100 scr_centre(2) scr_centre(1) - instrBox_width/2 + circSize*2 + 100 scr_centre(2) + circSize];
        circleRect(2,:) = [scr_centre(1) + instrBox_width/2 - circSize scr_centre(2) scr_centre(1) + instrBox_width/2 scr_centre(2) + circSize];
        %circleRect(4,:) = [scr_centre(1) + instrBox_width/2 - circSize*2 - 100 scr_centre(2) scr_centre(1) + instrBox_width/2 - circSize - 100 scr_centre(2) + circSize];
    end

    if instrTrial == 2 

        highCentre = (circleRect(1,1)+circleRect(1,3))/2;
        lowCentre = (circleRect(2,1)+circleRect(2,3))/2;  


        highString = ['If ' aOrAn(colourName(1,:)) ' ' strtrim(colourName(1,:)) ' shape is in the display, you will usually receive ' num2str(bigMultiplier) ' points.'];
        lowString = ['If ' aOrAn(colourName(2,:)) ' ' strtrim(colourName(2,:)) ' shape is in the display, you will usually receive ' num2str(smallMultiplier) ' points.'];


        % Screen('FillOval', MainWindow, distract_col(1,1:3), circleRect(1,:));
        % Screen('FillOval', MainWindow, distract_col(2,1:3), circleRect(2,:));
        %Screen('FillOval', MainWindow, distract_col(3,1:3), circleRect(4,:));
        %Screen('FillOval', MainWindow, distract_col(4,1:3), circleRect(3,:));

        [~, ny, highBox] = DrawFormattedText(instrWin, highString, 'left', ny+100 , textColour, 35, [], [], 1.5);
        highBox_width = highBox(3) - highBox(1);
        highBox_height = highBox(4) - highBox(2);
        [~, ~, lowBox] = DrawFormattedText(instrWin, lowString, 'left', ny+100 , textColour, 35, [], [], 1.5);
        lowBox_width = lowBox(3) - lowBox(1);
        lowBox_height = lowBox(4) - lowBox(2);
        highTextTop = circleRect(1,4) + 75;

        destHighBox = [highCentre - highBox_width / 2   highTextTop   highCentre + highBox_width / 2   highTextTop + highBox_height];
        destLowBox = [lowCentre - lowBox_width / 2   highTextTop   lowCentre + lowBox_width / 2   highTextTop + lowBox_height];

        Screen('DrawTexture', MainWindow, instrWin, highBox, destHighBox);
        Screen('DrawTexture', MainWindow, instrWin, lowBox, destLowBox);

    end
    
end


Screen('Flip', MainWindow, []);

Screen('TextSize', MainWindow, 34);

RestrictKeysForKbCheck(KbName('Space'));   % Only accept spacebar
KbWait([], 2);

Screen('Close', instrWin);

end

function out = aOrAn(colour)
    if strcmp(colour,'ORANGE')
        out = 'an';
    else
        out = 'a';
    end
end

function understanding_Test(trialType, insStr, qType)

global scr_centre colourName distract_col orange blue  black gray
global MainWindow yellow smallMultiplier bigMultiplier centOrCents white DATA trialCounter

trialCounter = trialCounter + 1;

valButtonWidth = 300;
valButtonHeight = 130;
valButtonTop = 300;
valButtonDisplacement = 230;

textColour = white;
Screen('TextFont', MainWindow, 'Courier');

x = 600;
y = 600;


valButtonWin = zeros(3,1);
for i = 1 : 3
    valButtonWin(i) = Screen('OpenOffscreenWindow', MainWindow, black, [0 0 valButtonWidth valButtonHeight]);
    Screen('FillRect', valButtonWin(i), gray);
    Screen('TextSize', valButtonWin(i), 30);
    Screen('TextFont', valButtonWin(i), 'Calibri');
end
DrawFormattedText(valButtonWin(1), ['0 points'], 'center', 'center', yellow);
DrawFormattedText(valButtonWin(2), [num2str(smallMultiplier), ' ', centOrCents], 'center', 'center', yellow);
DrawFormattedText(valButtonWin(3), [num2str(bigMultiplier), ' points'], 'center', 'center', yellow);

valButtonRect = zeros(3,4);
valButtonRect(1,:) = [scr_centre(1) - valButtonWidth*1.5 - valButtonDisplacement   valButtonTop   scr_centre(1) - valButtonWidth/2 - valButtonDisplacement  valButtonTop + valButtonHeight];
valButtonRect(2,:) = [scr_centre(1) - valButtonWidth/2   valButtonTop   scr_centre(1) + valButtonWidth/2  valButtonTop + valButtonHeight];
valButtonRect(3,:) = [scr_centre(1) + valButtonWidth/2 + valButtonDisplacement   valButtonTop   scr_centre(1) + valButtonWidth*1.5 + valButtonDisplacement  valButtonTop + valButtonHeight];

exImageRect = [scr_centre(1) - x/2    scr_centre(2)-50    scr_centre(1) + x/2   scr_centre(2) + y - 50];

if trialType < 5
    imageFilename = [strtrim(colourName(trialType,:)) '.jpg'];
elseif sum(distract_col(trialType,1:3) == orange) == 3 || sum(distract_col(trialType,1:3) == blue)==3
    imageFilename = 'ORANGEBLUE.jpg';
else
    imageFilename = 'GREENPINK.jpg';
end
    
    
ima = imread(imageFilename, 'jpg');
Screen('PutImage', MainWindow, ima, exImageRect);


instrWin = Screen('OpenOffscreenWindow', MainWindow, black);
Screen('TextSize', instrWin, 34);
Screen('TextStyle', instrWin, 1);

textColour = white;

[~, ~, instrBox] = DrawFormattedText(instrWin, insStr, 'left', 100 , textColour, 60, [], [], 1.5);
instrBox_width = instrBox(3) - instrBox(1);
instrBox_height = instrBox(4) - instrBox(2);
textTop = 150;
destInstrBox = [scr_centre(1) - instrBox_width / 2   textTop   scr_centre(1) + instrBox_width / 2   textTop + instrBox_height];

Screen('DrawTexture', MainWindow, instrWin, instrBox, destInstrBox);

for i = 1:3
    Screen('DrawTexture', MainWindow, valButtonWin(i), [], valButtonRect(i,:));
end

Screen('Flip', MainWindow, [], 1);
ShowCursor(0);

clickedValButton = 0;
    while clickedValButton == 0
        [~, x, y, ~] = GetClicks(MainWindow, 0);
        for i = 1 : 3
            if x > valButtonRect(i,1) && x < valButtonRect(i,3) && y > valButtonRect(i,2) && y < valButtonRect(i,4)
                clickedValButton = i;
            end
        end
    end

if clickedValButton == 1
        Screen('FillRect', MainWindow, black, valButtonRect(2,:));	% Hide button that hasn't been clicked
        Screen('FillRect', MainWindow, black, valButtonRect(3,:));
elseif clickedValButton == 2
        Screen('FillRect', MainWindow, black, valButtonRect(1,:));
        Screen('FillRect', MainWindow, black, valButtonRect(3,:));
else
        Screen('FillRect', MainWindow, black, valButtonRect(1,:));
        Screen('FillRect', MainWindow, black, valButtonRect(2,:));
end

fbStr = 'XX ERROR XX - ';
accuracy = 0;
if qType == 1
    switch trialType
        case {1,2}
            correctValButton = 3;
            if clickedValButton == correctValButton
                accuracy = 1;
                fbStr = 'Correct! - ';
            end
            fbStr = [fbStr 'You would receive 500 points'];
        case {3, 4}
            correctValButton = 2;
            if clickedValButton == correctValButton
                accuracy = 1;
                fbStr = 'Correct! - ';
            end
            fbStr = [fbStr 'You would receive 10 points'];
        case {5,6}
            correctValButton = 1;
            if clickedValButton == correctValButton
                accuracy = 1;
                fbStr = 'Correct! - ';
            end
            fbStr = [fbStr 'You would receive 0 points'];
    end
            
elseif qType == 2 
    switch trialType
        case {1,3, 5, 6}
            correctValButton = 1;
            if clickedValButton == correctValButton
                accuracy = 1;
                fbStr = 'Correct! - ';
            end
            fbStr = [fbStr 'You would receive 0 points'];
        case 2
            correctValButton = 3;
            if clickedValButton == correctValButton
                accuracy = 1;
                fbStr = 'Correct! - ';
            end
            fbStr = [fbStr 'You would receive 500 points'];
        case 4
            correctValButton = 2;
            if clickedValButton == correctValButton
                accuracy = 1;
                fbStr = 'Correct! - ';
            end
            fbStr = [fbStr 'You would receive 10 points'];
    end
elseif qType == 3
    switch trialType
        case {5, 6}
            correctValButton = 1;
            if clickedValButton == correctValButton
                accuracy = 1;
                fbStr = 'Correct! - ';
            end
            fbStr = [fbStr 'You would receive 0 points'];
    end
end

DATA.instrUnderstandingTest(trialCounter,:) = [trialCounter, trialType, qType, clickedValButton, correctValButton, accuracy];
    
DrawFormattedText(MainWindow, fbStr, 'center', valButtonRect(1,4)+75, textColour, 60, [], [], 1.5)

Screen('Flip', MainWindow);
if fbStr(1) == 'X'
    Beeper
end

HideCursor
WaitSecs(1.5)

end