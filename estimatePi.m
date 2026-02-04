function [p, crossings] = estimatePi(width,length,needles,needleCrosses)
        
    % Count the number of crossings
    crossings = sum(needleCrosses);

    % Prevent division by zero
    if crossings == 0
        p = 0;

    % Classic case
    elseif length < width
        p = (2 * length * needles) / (width * crossings);

    % General case
    else
        p = (2 * needles * (-length + sqrt(length^2-width^2)+width*asin(width/length)))...
            /(width*(needles-crossings));
    end
end