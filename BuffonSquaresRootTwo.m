%% Task 3 - modified version of "Buffon s needle" that drops squares to estimate sqrt(2)
% INPUTS, in order:
% width = the width of the floorboards;
% length = the length of the needles;
% throws = the number of needles thrown.
%
% OUTPUTS, in order:
% r = the estimate of sqrt(2),
% crossings = the number of needles that cross a plank;
%
% NOTE: should you need further input or output variables when integrating 
% the function to the GUI, you must implement the necessary  checks  using
% nargin and nargout to  ensure  the  function  works  correctly  outside 
% the GUI with the input and output combinations specified above.

function [r,crossings,squareCrossings,consecutiveCrossings,...
    needleCentre,needleAngle] ...
    = BuffonSquaresRootTwo(width,length,throws)

    % Default values
    if nargin < 3, throws = 1000000; end
    if nargin < 2, length = 5; end
    if nargin < 1, width = 10; end
    % Validate inputs
    if width <= 0
        error("Width must be greater than 0")
    elseif length <= 0
        error("Length must be greater than 0")
    elseif throws <= 0 || throws - round(throws) ~= 0
        error("Throws must be an integer greater than 0")
    elseif hypot(length, length) >= width
        error("Square must fit within 2 lines")
    end
    
    % Simulate squares
    [needleCentre, needleAngle, needleCrosses] = ...
        throwSquares(width, length, throws);
    
    % Estimate root two
    [r, crossings, squareCrossings, consecutiveCrossings] = ...
        estimateRootTwo(needleCrosses);
    
    if nargout < 5
        needleCentre = [];
        needleAngle = [];
    end
end