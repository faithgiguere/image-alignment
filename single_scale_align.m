function [B, G_aligned, R_aligned] = single_scale_align(B, G, R)
    % Trim images on all sides to only compare interiors
    B_y_min = int64(size(B,1) * .25);
    B_y_max = int64(size(B,1) * .75);
    B_x_min = int64(size(B,2) * .25);
    B_x_max = int64(size(B,2) * .75);
    B_trimmed = B(B_y_min:B_y_max, B_x_min:B_x_max);
    G_y_min = int64(size(G,1) * .25);
    G_y_max = int64(size(G,1) * .75);
    G_x_min = int64(size(G,2) * .25);
    G_x_max = int64(size(G,2) * .75);
    G_trimmed = G(G_y_min:G_y_max, G_x_min:G_x_max);
    R_y_min = int64(size(R,1) * .25);
    R_y_max = int64(size(R,1) * .75);
    R_x_min = int64(size(R,2) * .25);
    R_x_max = int64(size(R,2) * .75);
    R_trimmed = R(R_y_min:R_y_max, R_x_min:R_x_max);
    
    % Align G to B
    min = 100000;
    X = 0;
    Y = 0;
    for x = -15:15
        for y = -15:15
            shifted = circshift(G_trimmed,[y x]); 
            diff = sum(sum((shifted-B_trimmed).^2));
            if diff < min
                min = diff;
                X = x;
                Y = y;
            end
        end
    end
    G_aligned = circshift(G, [Y X]);
    
    % Align R to B
    min = 100000;
    X = 0;
    Y = 0;
    for x = -15:15
        for y = -15:15
            shifted = circshift(R_trimmed,[y x]); 
            diff = sum(sum((shifted-B_trimmed).^2));
            if diff < min
                min = diff;
                X = x;
                Y = y;
            end
        end
    end
    R_aligned = circshift(R, [Y X]);
end