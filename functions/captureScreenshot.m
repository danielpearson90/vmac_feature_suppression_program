function captureScreenshot(windowPtr, counterbalance, targetType)

global scr_centre

switch counterbalance
	case 1
		filename = 'diamondFeatureExample.jpg';
	case 2
		filename = 'circleFeatureExample.jpg';
	case 3
		if targetType == 1
			filename = 'diamondSingletonExample.jpg';
		else
			filename = 'circleSingletonExample.jpg';
		end
	case 4
		if targetType == 1
			filename = 'diamondFeatureExample.jpg';
		else
			filename = 'circleFeatureExample.jpg';
		end
end

rectSize = [649, 547];
captureRect = [scr_centre(1) - rectSize(1)/2, scr_centre(2) - rectSize(2)/2, scr_centre(1) + rectSize(1)/2, scr_centre(2) + rectSize(2)/2];

imageArray = Screen('GetImage', windowPtr, captureRect);
imwrite(imageArray, filename, 'jpg');



end