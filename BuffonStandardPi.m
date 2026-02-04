%% Task 1 - standard version of “Buffon’s needle”
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

function [p,crossings,centre,angle] = ...
    BuffonStandardPi(width,length,throws)
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

    % Generate random list of needle centre positions
    centre = rand(throws, 1) * width/2;

    % Generate random list of needle angles
    angle = rand(throws, 1) * pi/2;

    % Calculate half of the horizontal projection of each needle
    horizontalProjection = (length * sin(angle)) / 2;
    
    % Check for needles that cross a line
    needleCrosses = centre <= horizontalProjection;

    [p,crossings] = estimatePi(width,length,throws,needleCrosses);

    if nargout < 3
        centre = [];
        angle = [];
    end
end