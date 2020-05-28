% function computing the rotation matrix, given theta and alpha (see DH
% convention)

function T=orDH_R(theta,alpha)

    T=[cos(theta)   -sin(theta)*cos(alpha)  sin(theta)*sin(alpha);...
       sin(theta)   cos(theta)*cos(alpha)   -cos(theta)*sin(alpha);...
       0            sin(alpha)              cos(alpha)];

    % threshold on numerical errors (e.g. if a coefficient is smaller than
    % 1e-10, this coefficient is 0)
    threshold = 1e-10; 
    
    % this part has been added to adjust numerical errors for symbolic
    % matrices
    if isa(T,'sym')
        for i=1:size(T,1)
            for j=1:size(T,2)
                coeff_ij = eval(coeffs(T(i,j)));
                if (abs(coeff_ij) < threshold)
                    T(i,j) = 0;
                end
            end
        end
    end
end