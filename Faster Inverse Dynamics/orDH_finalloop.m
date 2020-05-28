function tau = orDH_finalloop(i,R_matrices, M)

    Ri = R_matrices{i};
    z_im1 = Ri'*[0;0;1];
    tau = M(:,i)'*z_im1;
    
end

