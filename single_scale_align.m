function d = single_scale_align(image1, image2)
    min = 100000;
    % Trim images on all sides to only compare interiors
    image1_y_min = int64(size(image1,1) * .25);
    image1_y_max = int64(size(image1,1) * .75);
    image1_x_min = int64(size(image1,2) * .25);
    image1_x_max = int64(size(image1,2) * .75);
    image1 = image1(image1_y_min:image1_y_max, image1_x_min:image1_x_max);
    image2_y_min = int64(size(image2,1) * .25);
    image2_y_max = int64(size(image2,1) * .75);
    image2_x_min = int64(size(image2,2) * .25);
    image2_x_max = int64(size(image2,2) * .75);
    image2 = image2(image2_y_min:image2_y_max, image2_x_min:image2_x_max);
    
    for x = -15:15
        for y = -15:15
            shifted = circshift(image1,[y x]); 
            diff = sum(sum((shifted-image2).^2));
            if diff < min
                min = diff;
                X = x;
                Y = y;
            end
        end
    end
    d = [Y, X];
end