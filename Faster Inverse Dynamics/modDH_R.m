% function computing the rotation matrix, given theta and alpha (see DH
% convention)


function T=modDH_R(theta,alpha_im1)

    T=[cos(theta)               -sin(theta)             0           ;...
       cos(alpha_im1)*sin(theta)    cos(alpha_im1)*cos(theta)   -sin(alpha_im1) ;...
       sin(alpha_im1)*sin(theta)    sin(alpha_im1)*cos(theta)   cos(alpha_im1)  ];

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