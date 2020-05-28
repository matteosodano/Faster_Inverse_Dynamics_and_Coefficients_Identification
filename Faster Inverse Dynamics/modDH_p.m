% This function returns the position of frame i 
% with respect to frame i-1, described with respect to frame i itself
% d, a, alpha are referred to DH convention
function p_im1_i = modDH_p(d,a_im1,alpha_im1)

    p_im1_i = [a_im1 ; -d*sin(alpha_im1) ; d*cos(alpha_im1)];

end