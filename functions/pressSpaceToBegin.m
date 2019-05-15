function pressSpaceToBegin()

global MainWindow

DrawFormattedText(MainWindow, 'Please let the experimenter know when you are ready', 'center', 'center' , [255 255 255]);

Screen(MainWindow, 'Flip');

RestrictKeysForKbCheck(KbName('Space'));   % Only accept spacebar
KbWait([], 2);

Screen(MainWindow, 'Flip');

end

