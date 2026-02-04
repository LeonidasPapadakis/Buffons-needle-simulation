function [needleCentre,needleAngle,needleCrosses,needles] = ...
    throwSquares(width,length,throws)

    halfLength = length / 2;
    needles = throws * 4;
    
    % Generate four sides of squares
    needleCentre = [halfLength, 0;
        0, halfLength;
        - halfLength, 0;
        0, - halfLength];
    needleCentre = repmat(needleCentre, throws ,1);
   
    % Generate random rotation angles from 0:Pi/2
    rotationAngle = rand(throws, 1) * pi/2;
    needleAngle = [pi/2 - rotationAngle, rotationAngle,...
                    pi/2 - rotationAngle, rotationAngle];
    needleAngle = reshape(needleAngle.', 1, needles).';

    % Create rotation matrices
    rotationAngle = repelem(rotationAngle, 4);
    rotation = zeros(2,2,needles);
    rotation(1,1,:) = cos(rotationAngle);
    rotation(1,2,:) = -sin(rotationAngle);
    rotation(2,1,:) = sin(rotationAngle);
    rotation(2,2,:) = cos(rotationAngle);
    
    % Apply rotations to each square
    needleCentre = permute(needleCentre.',[1,3,2]);
    needleCentre = pagemtimes(rotation, needleCentre);
    needleCentre = permute(needleCentre, [3,1,2]);

    % Generate random list of square centre positions
    squareCentre = repelem(rand(throws, 1) * width / 2, 4, 1);

    % Translate needles in each square to lie about centre
    needleCentre(:,1) = needleCentre(:,1) + squareCentre;
    
    % Fold the needle centres over the interval 0,width/2
    needleCentreX = needleCentre(:,1);
    needleCentreX = mod(needleCentreX, width);
    needleCentreX = min(needleCentreX, width - needleCentreX);
   
    % Calculate horizontal projection of each needle
    horizontalProjection = halfLength * cos(needleAngle);
    
    % Calculate which needles cross lines
    needleCrosses = needleCentreX <= horizontalProjection;
end