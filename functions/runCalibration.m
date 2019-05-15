function runCalibration()

global p_number
global MainWindow
global calibrationNum
global exptSession

Screen('Close', MainWindow);

SetCalibParams;

disp('Starting TrackStatus');
TrackStatus; % Track status window will stay open until user key press.
disp('TrackStatus stopped');
close ALL;

calibrationNum = calibrationNum + 1;

% Perform calibration
CalibPoints = HandleCalibWorkflowMLP(Calib);
close ALL HIDDEN;

filepath = ['CalibrationData\P', num2str(p_number), '_Cal', num2str(calibrationNum)];

save(filepath,'CalibPoints')

clear

setupMainWindowScreen;
HideCursor;

end
