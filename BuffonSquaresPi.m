%% Task 2 - modified version of “Buffon’s needle” that drops squares
% INPUTS, in order:
% width = the width of the floorboards;
% length = the length of the needles;
% throws = the number of needles thrown.
%
% OUTPUTS, in order:
% p = the estimate of pi,
% crossings = the number of needles that cross a plank;
%
% NOTE: should you need further input or output variables when integrating 
% the function to the GUI, you must implement the necessary  checks  using
% nargin and nargout to  ensure  the  function  works  correctly  outside 
% the GUI with the input and output combinations specified above.

function [p,crossings,needleCentre,needleAngle] = ...
    BuffonSquaresPi(width,length,throws)
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
    end
    
    % Simulate squares
    [needleCentre, needleAngle, needleCrosses, needles] = ...
        throwSquares(width, length, throws);
    
    % Estimate pi
    [p,crossings] = estimatePi(width,length,needles,needleCrosses);
    
    % Remove unneeded outputs
    if nargout < 3
        needleCentre = [];
        needleAngle = [];
    end
end