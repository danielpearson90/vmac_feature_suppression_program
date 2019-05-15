
function initialInstructions()

global MainWindow white targetBalance

switch targetBalance
	case 1
		targetStr = 'DIAMOND';
	case 2
		targetStr = 'CIRCLE';
	case 3
		targetStr = 'UNIQUE';
	case 4
		targetStr = 'CIRCLE or DIAMOND';
end

instructStr1 = 'On each trial a cross will appear inside a circle, and a yellow spot will show you where the computer thinks your eyes are looking. You should fix your eyes on the cross. After a short time the cross will turn yellow and the spot will disappear - this shows that the trial is about to start. You should keep your eyes fixed in the middle of the screen until the trial starts.';
instructStr2 = ['Then a set of shapes will appear; an example is shown below. Your task is to move your eyes to look at the ', targetStr, ' shape as quickly and as directly as possible.'];

show_Instructions(1, instructStr1);
show_Instructions(2, instructStr2);

Screen('TextSize', MainWindow, 32);
Screen('TextStyle', MainWindow, 1);
Screen('TextFont', MainWindow, 'Courier');

DrawFormattedText(MainWindow, 'Tell the experimenter when you are ready to begin', 'center', 'center' , white);
Screen(MainWindow, 'Flip');

RestrictKeysForKbCheck(KbName('c'));   % Only accept c key
KbWait([], 2);
Screen(MainWindow, 'Flip');
RestrictKeysForKbCheck([]); % Re-enable all keys

end

function show_Instructions(instrTrial, insStr)

global MainWindow scr_centre black white targetBalance

switch targetBalance
	case 1
		imageFilename = 'diamondFeatureExample.jpg';
	case 2
		imageFilename = 'circleFeatureExample.jpg';
	case 3
		imageFilename = 'diamondSingletonExample.jpg';
		imageFilename2 = 'circleSingletonExample.jpg';
    case 4 
        imageFilename = 'diamondFeatureExample.jpg';
        imageFilename2 = 'circleFeatureExample.jpg';
end


x = 649;
y = 547;
gapBetween = x/2 + 50;


exImageRect  = [scr_centre(1) - x/2                 scr_centre(2)-50    scr_centre(1) + x/2   				scr_centre(2) + y - 50];
exImageRect2 = [scr_centre(1) - gapBetween - x/2    scr_centre(2)-50	scr_centre(1) - gapBetween + x/2	scr_centre(2) + y - 50];
exImageRect3 = [scr_centre(1) + gapBetween - x/2    scr_centre(2)-50	scr_centre(1) + gapBetween + x/2	scr_centre(2) + y - 50];

RestrictKeysForKbCheck(KbName('Space'));   % Only accept spacebar


instrWin = Screen('OpenOffscreenWindow', MainWindow, black);
Screen('TextSize', instrWin, 32);
Screen('TextStyle', instrWin, 1);

[~, ~, instrBox] = DrawFormattedText(instrWin, insStr, 'centerblock', 'center' , white, 60, [], [], 1.5);
instrBox_width = instrBox(3) - instrBox(1);
instrBox_height = instrBox(4) - instrBox(2);
textTop = 100;
destInstrBox = [scr_centre(1) - instrBox_width / 2   textTop   scr_centre(1) + instrBox_width / 2   textTop +  instrBox_height];
Screen('DrawTexture', MainWindow, instrWin, instrBox, destInstrBox);

if instrTrial == 1
    ima1=imread('image1.jpg', 'jpg');
    ima2=imread('image2.jpg', 'jpg');
    Screen('PutImage', MainWindow, ima1, exImageRect); % put image on screen
    Screen(MainWindow, 'Flip');
    KbWait([], 2);
    Screen('DrawTexture', MainWindow, instrWin, instrBox, destInstrBox);
    Screen('PutImage', MainWindow, ima2, exImageRect); % put image on screen
    
elseif instrTrial == 2
    ima1 = imread(imageFilename, 'jpg');
    targetStringTex = Screen('OpenOffscreenWindow', MainWindow, black);
    Screen('TextSize', targetStringTex, 42);
    Screen('TextFont', targetStringTex, 'Courier New');
    Screen('TextStyle', targetStringTex, 1);
    [~, ~, targetTextBox] = DrawFormattedText(targetStringTex, 'Target', 'center', 'center', white, [], [], [], 1.5);
    targetTextW = targetTextBox(3) - targetTextBox(1);
    targetTextH = targetTextBox(4) - targetTextBox(2);
    targetTextVoffset = -180;

    arrowTex = drawArrow(80, 25, 40, 10);
    arrowW = 40;
    arrowH = 80;
    if targetBalance == 3 || targetBalance == 4
    	ima2 = imread(imageFilename2, 'jpg');
    	Screen('PutImage', MainWindow, ima1, exImageRect2);
    	Screen('PutImage', MainWindow, ima2, exImageRect3);
    	Screen('FrameRect', MainWindow, [255 255 255], exImageRect2, 2);
    	Screen('FrameRect', MainWindow, [255 255 255], exImageRect3, 2);
          arrowRect(1,:) = [scr_centre(1) - targetTextW/2 - arrowW - 50, scr_centre(2) + y + targetTextVoffset, scr_centre(1) - targetTextW/2 - 50, scr_centre(2) + y + targetTextVoffset + arrowH];
        arrowRect(2,:) = [scr_centre(1) + targetTextW/2 + 50, scr_centre(2) + y + targetTextVoffset, scr_centre(1) + targetTextW/2 + arrowW + 50, scr_centre(2) + y + targetTextVoffset + arrowH];
        targetTextRect = [scr_centre(1) - targetTextW/2, scr_centre(2) + y - 160, scr_centre(1) + targetTextW/2, scr_centre(2) + y + targetTextH - 160];
        % targetTextRect(2,:) = [scr_centre(1) + gapBetween - targetTextW/2, scr_centre(2) + y + targetTextVoffset + arrowH + targetTextVoffset, scr_centre(1) + gapBetween + targetTextW/2, scr_centre(2) + y + targetTextVoffset + arrowH + targetTextVoffset + targetTextH];
        Screen('DrawTexture', MainWindow, arrowTex, [], arrowRect(1,:), 270);
        Screen('DrawTexture', MainWindow, arrowTex, [], arrowRect(2,:), 90);
        Screen('DrawTexture', MainWindow, targetStringTex, targetTextBox, targetTextRect);
        % Screen('DrawTexture', MainWindow, targetStringTex, targetTextBox, targetTextRect(2,:));
    else
    	Screen('PutImage', MainWindow, ima1, exImageRect); % put image on screen
    	Screen('FrameRect', MainWindow, [255 255 255], exImageRect, 2);
	end

    
    
end


Screen(MainWindow, 'Flip');

KbWait([], 2);

Screen('Close', instrWin);

end