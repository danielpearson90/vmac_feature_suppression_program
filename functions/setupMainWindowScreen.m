function setupMainWindowScreen()

global MainWindow screenNum

MainWindow = Screen(screenNum, 'OpenWindow', [0 0 0], [], 32);
Screen('Preference', 'DefaultFontName', 'Courier New');
Screen('TextSize', MainWindow, 34);
Screen('TextStyle', MainWindow, 1);

end

