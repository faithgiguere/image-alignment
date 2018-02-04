function [B, G_aligned, R_aligned] = single_scale_align(B, G, R)
    % Single scale alignment range -- how many pixels +/- to check
    % for best alignment
    RANGE = 15;
    
    % Align G to B
    [X, Y] = best_displacement(G, B, RANGE);
    G_aligned = circshift(G, [Y X]);
    
    % Align R to B
    [X, Y] = best_displacement(R, B, RANGE);
    R_aligned = circshift(R, [Y X]);
end