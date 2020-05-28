function VREP_data()
    l = load('joint_position.mat');
    q = l.q;
    fout = fopen('q.txt', 'wt');
    dim = length(q);
    for i=1:dim
        fprintf(fout, '%f %f %f %f %f %f %f\n', q(1,i), q(2, i), q(3, i), q(4, i), q(5, i), q(6, i), q(7, i));
    end
    fclose(fout);
end

