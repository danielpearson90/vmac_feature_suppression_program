function arrowTex = drawArrow(arrow_length, head_height, head_width, stroke_width)

global MainWindow white

arrowTex = Screen('OpenOffscreenWindow', MainWindow, [0 0 0 0], [0 0 head_width arrow_length]);

aHead_pts = [0, head_height; head_width/2, 0; head_width, head_height];

Screen('FillPoly', arrowTex, white, aHead_pts);

Screen('DrawLine', arrowTex, white, head_width/2, head_height, head_width/2, arrow_length, stroke_width);


end