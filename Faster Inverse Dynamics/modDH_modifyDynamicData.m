%% Transformation from DH to mod DH of centers of masses and inertias

function [modified_cm, modified_inertias] = modDH_modifyDynamicData(old_cm, old_inertias)
    % rotation matrix around x axis
    rotationAroundX =@(q) [1 0 0;...
                           0 cos(q) -sin(q);...
                           0 sin(q) cos(q)];        
    % number of joints
    N = 7;
   
    R_DH_modDH = cell(1,7); 
    modified_inertias = cell(1,7);
    
    R_DH_modDH{1} = rotationAroundX(pi/2);
    R_DH_modDH{2} = rotationAroundX(-pi/2);
    R_DH_modDH{3} = rotationAroundX(-pi/2);
    R_DH_modDH{4} = rotationAroundX(pi/2);
    R_DH_modDH{5} = rotationAroundX(pi/2);
    R_DH_modDH{6} = rotationAroundX(-pi/2);
    R_DH_modDH{7} = rotationAroundX(0);
    
    modified_cm = zeros(3,7);
    for i=1:N
        % conversion of center of masses and inertias from DH to modified DH
        modified_cm(:,i) = R_DH_modDH{i}*old_cm(:,i);
        modified_inertias{i} = R_DH_modDH{i} * old_inertias{i} * R_DH_modDH{i}'; 
    end
   
end

