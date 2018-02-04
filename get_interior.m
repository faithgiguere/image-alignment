% Trim 25% off of each side of image
function interior = get_interior(image)
    image_y_min = int64(size(image,1) * .25);
    image_y_max = int64(size(image,1) * .75);
    image_x_min = int64(size(image,2) * .25);
    image_x_max = int64(size(image,2) * .75);
    interior = image(image_y_min:image_y_max, image_x_min:image_x_max);
end