function calibPlotData = CalibratePTB(Calib, morder, iter,donts)

global MainWindow


calibrateWin = Screen('OpenOffscreenWindow', MainWindow, Calib.bkcolor);
Screen('BlendFunction', calibrateWin, GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA); %This allows for transparent background on white dot

Calib.mondims = Calib.mondims1;

if (iter==0)
    tetio_startCalib;
    tetio_clearCalib(); % clears previous calibration results
end

idx = 0;
validmat = ones(1,Calib.points.n);
%generate validity matrix
if ~isempty(donts)
    validmat = zeros(1,Calib.points.n);
    for i = 1:length(donts)
        validmat(morder==donts(i))=1;
    end
end
pause(1);
step = 10; %shrinking steps

%Draw shrinking blue circle
BigMarkerRect = [0 0 Calib.BigMark Calib.BigMark];
BigMarkerCentre = Calib.BigMark/2;
ms = Calib.BigMark;
for aa = 1:step
    BigMarker(aa,:) = Screen('OpenOffscreenWindow', MainWindow, Calib.bkcolor, BigMarkerRect);
    Screen('FillOval', BigMarker(aa,:), [Calib.fgcolor, 255], [BigMarkerCentre-ms/2 BigMarkerCentre-ms/2 BigMarkerCentre+ms/2 BigMarkerCentre+ms/2], ms);
    Screen('FrameOval', BigMarker(aa,:), [Calib.bkcolor, 255], [BigMarkerCentre-ms/2 BigMarkerCentre-ms/2 BigMarkerCentre+ms/2 BigMarkerCentre+ms/2], 1);
    ms = ms-ceil((Calib.BigMark - Calib.SmallMark)/step);
end

%Draw small red circle
SmallMarkerRect = [0 0 Calib.SmallMark Calib.SmallMark];
SmallMarkerCentre = Calib.SmallMark/2;
SmallMarker = Screen('OpenOffscreenWindow', MainWindow, [Calib.bkcolor, 0], SmallMarkerRect); %alpha value of zero to allow transparency when drawing dots on top of each other
Screen('FillOval', SmallMarker, [Calib.fgcolor2, 255], [], Calib.SmallMark);
Screen('FrameOval', SmallMarker, [Calib.bkcolor, 255],[],  1);

for i = 1:Calib.points.n
    Screen('FillRect', calibrateWin, Calib.bkcolor);
    idx = idx + 1;
    if (idx ~=1)
        %%% come back to this
    end
    
    for j = 1:step
        Screen('FillRect', calibrateWin, Calib.bkcolor);
        Screen('DrawTexture', calibrateWin, BigMarker(j,:), [], [(Calib.mondims.width*Calib.points.x(morder(i))) - Calib.BigMark/2, (Calib.mondims.height*Calib.points.y(morder(i))) - Calib.BigMark/2, (Calib.mondims.width*Calib.points.x(morder(i))) + Calib.BigMark/2, (Calib.mondims.height*Calib.points.y(morder(i))) + Calib.BigMark/2]);
        Screen('DrawTexture', calibrateWin, SmallMarker, [], [(Calib.mondims.width*Calib.points.x(morder(i))) - Calib.SmallMark/2, (Calib.mondims.height*Calib.points.y(morder(i))) - Calib.SmallMark/2, (Calib.mondims.width*Calib.points.x(morder(i))) + Calib.SmallMark/2, (Calib.mondims.height*Calib.points.y(morder(i))) + Calib.SmallMark/2]);
        
        Screen('DrawTexture', MainWindow, calibrateWin, [], [1 1 1920 1080]);
        Screen(MainWindow, 'Flip');
        if (j==1)
            pause(0.5);
        end
        if (j==step)
            tetio_addCalibPoint(Calib.points.x(morder(i)), Calib.points.y(morder(i)));
            pause(0.2);
        end
        pause(0.1);
    end
end

Screen(MainWindow, 'Flip');

pause(0.5);
tetio_computeCalib;

Screen('Close', calibrateWin);
Screen('Close', BigMarker(:,:));
Screen('Close', SmallMarker);

calibPlotData = tetio_getCalibPlotData;
end