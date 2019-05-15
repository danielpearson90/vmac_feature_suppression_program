% New TrackStatus Script

%Use spacebar (or any other) key press to continue.
%   Input:
%         Calib: The calib config structure (see SetCalibParams)

global MainWindow


if (Calib.resize)
    figloc.x =  Calib.mondims1.x + Calib.mondims1.width/4;
    figloc.y =  Calib.mondims1.y + Calib.mondims1.height/4;
    figloc.width =  Calib.mondims1.width/2;
    figloc.height =  Calib.mondims1.height/2;
else
    figloc =  Calib.mondims1;
end

destTrackingBoxLoc = [figloc.x, figloc.y, figloc.x+figloc.width, figloc.y+figloc.height];

Calib.mondims = figloc;

TrackingBox = Screen('OpenOffscreenWindow', MainWindow, Calib.bkcolor, destTrackingBoxLoc);
GreenEye = Screen('OpenOffscreenWindow', MainWindow, Calib.bkcolor, [0 0 Calib.TrackStat Calib.TrackStat]);
Screen('FillOval', GreenEye, [0 255 0], [], 25);
YellowEye = Screen('OpenOffscreenWindow', MainWindow, Calib.bkcolor, [0 0 Calib.TrackStat, Calib.TrackStat]);
Screen('FillOval', YellowEye, [255 255 0], [], 25);

breakLoopFlag=0;
updateFrequencyInHz = 60;

tetio_startTracking;

validLeftEyePos = 0;
validRightEyePos = 0;


while(~breakLoopFlag)
    
    pause(1/updateFrequencyInHz);
    
    Screen('FillRect', TrackingBox, Calib.bkcolor);
    Screen('FrameRect', TrackingBox, Calib.frameColor, [], 2);
    
    RestrictKeysForKbCheck(32);
    [keyIsDown,secs,keyCode]=KbCheck;
    if keyIsDown
        breakLoopFlag=1;
    end
    
    [lefteye, righteye, timestamp, trigSignal] = tetio_readGazeData;
    
    if isempty(lefteye)
        continue;
    end
    
    GazeData = ParseGazeData(lefteye(end,:), righteye(end,:)); % Parse last gaze data.
    
    if  (GazeData.left_validity==0) && (GazeData.right_validity==0)
        eyeDot = GreenEye;
    else
        eyeDot = YellowEye;
    end
    
    validLeftEyePos = GazeData.left_validity <= 2;
    validRightEyePos = GazeData.right_validity < 2; % If both left and right validities are 2 then only draw left.
    
    if validLeftEyePos || validRightEyePos
        if validLeftEyePos
            if GazeData.left_eye_position_3d_relative.x * Calib.mondims.width < destTrackingBoxLoc(3) && GazeData.left_eye_position_3d_relative.y * Calib.mondims.height < destTrackingBoxLoc(4)
                Screen('DrawTexture', TrackingBox, eyeDot, [], [((1-GazeData.left_eye_position_3d_relative.x) * Calib.mondims.width)-Calib.TrackStat/2, (GazeData.left_eye_position_3d_relative.y * Calib.mondims.height)-Calib.TrackStat/2, ((1-GazeData.left_eye_position_3d_relative.x) * Calib.mondims.width)+Calib.TrackStat/2, (GazeData.left_eye_position_3d_relative.y * Calib.mondims.height)+Calib.TrackStat/2]);
            end
        end
        
        if validRightEyePos
            if GazeData.right_eye_position_3d_relative.x * Calib.mondims.width < destTrackingBoxLoc(3) && GazeData.right_eye_position_3d_relative.y * Calib.mondims.height < destTrackingBoxLoc(4)
                Screen('DrawTexture', TrackingBox, eyeDot, [], [((1-GazeData.right_eye_position_3d_relative.x) * Calib.mondims.width)-Calib.TrackStat/2, (GazeData.right_eye_position_3d_relative.y * Calib.mondims.height)-Calib.TrackStat/2, ((1-GazeData.right_eye_position_3d_relative.x) * Calib.mondims.width)+Calib.TrackStat/2, (GazeData.right_eye_position_3d_relative.y * Calib.mondims.height)+Calib.TrackStat/2]);
            end
        end
        
        
    end
    Screen('DrawTexture', MainWindow, TrackingBox, [], destTrackingBoxLoc);
    Screen(MainWindow, 'Flip');
end

Screen(MainWindow, 'Flip');

Screen('Close', TrackingBox);
Screen('Close', GreenEye);
Screen('Close', YellowEye);

tetio_stopTracking;