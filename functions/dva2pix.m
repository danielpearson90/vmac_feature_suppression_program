function [pixels] = dva2pix(dva);

global screenRes viewDistance monitorDims

pixels = tand(dva/2) * 2 * viewDistance * screenRes(1)/monitorDims(1);

pixels = round(pixels);

end