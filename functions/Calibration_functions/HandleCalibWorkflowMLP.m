function pts = HandleCalibWorkflowMLP(Calib)
%HandleCalibWorkflow Main function for handling the calibration workflow.
%   Input:
%         Calib: The calib config structure (see SetCalibParams)
%   Output:
%         pts: The list of points used for calibration. These could be
%         further used for the analysis such as the variance, mean etc.


while(1)
    
    try
        
        mOrder = randperm(Calib.points.n);
        calibplot = Calibrate(Calib, mOrder, 0, []);
        pts = PlotCalibrationPoints(calibplot, Calib, mOrder);% Show calibration points and compute calibration.

        h = 'a';
        while h(1) ~= 'y' && h(1) ~= 'Y' && h(1) ~= 'n' && h(1) ~= 'N'
            h = input('Accept calibration? (y/n):','s');
            if isempty(h); h = 'a'; end
        end

        if h(1) == 'y' ||  h(1) == 'Y'
            tetio_stopCalib;
            close;
            return;
        else
            close all;
            tetio_stopCalib;
        end
        

    catch ME    %  Calibration failed
        tetio_stopCalib;
        
        disp('Not enough calibration data.');
        h = 'a';
        while h(1) ~= 'y' && h(1) ~= 'Y'
            h = input('Type y to try again, otherwise you''ll need to quit with ctrl-C (y):','s');
            if isempty(h); h = 'a'; end
        end
        close all;
        continue;
        
    end
end








