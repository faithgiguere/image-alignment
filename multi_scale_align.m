function [B, G, R] = multi_scale_align(B_full, G_full, R_full)
    % Multi Scale Iterations
    % How many iterations (blur and sample) deep to go
    MSI = 5;
    
    pyramid = cell(MSI, 3);
    pyramid{1, 1} = B_full;
    pyramid{1, 2} = G_full;
    pyramid{1, 3} = R_full;
    for i = 2:MSI
        % Blur images
        B = imgaussfilt(pyramid{i-1, 1}, 3);
        G = imgaussfilt(pyramid{i-1, 2}, 3);
        R = imgaussfilt(pyramid{i-1, 3}, 3);
        
        % Get every other pixel
        B = B(1:2:end,1:2:end);
        G = G(1:2:end,1:2:end);
        R = R(1:2:end,1:2:end);
        
        pyramid{i, 1} = B;
        pyramid{i, 2} = G;
        pyramid{i, 3} = R;
    end
    
    % Find best displacement for G into B for lowest res image
    for i = MSI:-1:1
        % Get new best displacement +/- i^2 around current res
        [X, Y] = best_displacement(pyramid{i, 2}, pyramid{i, 1}, i^2 + 5);
        % Shift higher res images by best displacement
        for j = i:-1:1
            pyramid{j, 2} = circshift(pyramid{j, 2}, [Y*(2^(i-j+1)) X*(2^(i-j+1))]);
        end
    end
    
    % Find best displacement for R into B for lowest res image
    for i = MSI:-1:1
        % Get new best displacement +/- i^2 around current res
        [X, Y] = best_displacement(pyramid{i, 3}, pyramid{i, 1}, i^2 + 5);
        % Shift higher res images by best displacement
        for j = i:-1:1
            pyramid{j, 3} = circshift(pyramid{j, 3}, [Y*(2^(i-j+1)) X*(2^(i-j+1))]);
        end
    end
    B = B_full;
    G = pyramid{1, 2};
    R = pyramid{1, 3};
end









