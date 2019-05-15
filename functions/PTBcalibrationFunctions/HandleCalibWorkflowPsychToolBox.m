function pts = HandleCalibWorkflowPsychToolBox(Calib)
global MainWindow
while (1)
    
    try
        
        mOrder = randperm(Calib.points.n);
        calibplot = CalibratePTB(Calib, mOrder, 0, []);
        [pts, keyPressed] = PlotCalibrationPointsPTB(calibplot, Calib, mOrder);
        while(1)
            if strcmp(keyPressed, 'y')
                tetio_stopCalib;
                return;
            elseif strcmp(keyPressed, 'n')
                tetio_stopCalib;
                break;
            end
        end
    catch ME
        tetio_stopCalib;
        Screen('TextSize', MainWindow, 36);
        Screen('TextFont', MainWindow, 'Calibri');
        Screen('TextStyle', MainWindow, 1);
        DrawFormattedText(MainWindow, 'NOT ENOUGH CALIBRATION DATA. Do you want to try again? ([y]/n)', 'center', 'center', [255 255 255],120,[],[],1.5);
        Screen(MainWindow, 'Flip');
        RestrictKeysForKbCheck([89,78]);
        KbWait([],2);
        [~, ~, keyCode] = KbCheck;      % This stores which key is pressed as a keyCode
        keyPressed = KbName(keyCode);
        if strcmp(keyPressed, 'y')
            Screen(MainWindow, 'Flip');
            continue;
        elseif strcmp(keyPressed, 'n');
            sca;
            ShowCursor;
            return;
        end
    end
end