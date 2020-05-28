% This function returns the position of frame i 
% with respect to frame i - 1, described with respect to frame i itself
% d, a, alpha are referred to DH convention

function p_im1_i = orDH_p(d,a,alpha)

    p_im1_i = [a ; d*sin(alpha) ; d*cos(alpha)];

end