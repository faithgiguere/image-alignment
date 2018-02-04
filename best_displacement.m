% Finds best displacement to align image1 with image2
function [X, Y] = best_displacement(image1, image2, range)
    % Trim images on all sides to only compare interiors
    image1 = get_interior(image1);
    image2 = get_interior(image2);
    min = 1000000000000;
    for x = -range:range
        for y = -range:range
            shifted = circshift(image1,[y x]); 
            diff = sum(sum((shifted-image2).^2));
            if diff < min
                min = diff;
                X = x;
                Y = y;
            end
        end
    end
end