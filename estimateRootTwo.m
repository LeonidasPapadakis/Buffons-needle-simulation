function [r, totalCrossings, squareCrossings, consecutiveCrossings] = ...
    estimateRootTwo(needleCrosses)

    % Reshape crossings matrix into throws x 4 matrix where each column 
    % is a side A B C D of a square
    crossings = reshape(needleCrosses, 4, []).';

    % Count total crossings
    totalCrossings = sum(crossings,"all");

    % Count square crossings
    squareCrossings = sum(crossings(:,1) | crossings(:,2) ...
        | crossings(:,3) | crossings(:,4));
    
    % Count the number of times two consecutive needles cross a line
    consecutiveCrossings = sum(crossings(:,1) & crossings(:,2) ...
        | crossings(:,2) & crossings(:,3) ...
        | crossings(:,3) & crossings(:,4) ...
        | crossings(:,4) & crossings(:,1));

    % Prevent division by zero
    if squareCrossings == 0
        r = 0;
    else
        r = 2 - consecutiveCrossings / squareCrossings;
    end
end