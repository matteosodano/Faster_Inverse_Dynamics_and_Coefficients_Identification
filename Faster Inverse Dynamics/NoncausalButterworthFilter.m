%%%%%%%%%%%%
% NEW CODE %
%%%%%%%%%%%%
function Matrix_filt = NoncausalButterworthFilter(Matrix)
% The function returns the filtered version of Matrix.
% Matrix collects the time history of a vector (it is a thin matrix). 
% Its rows are the samples, its colums are different components of the 
% vector.

[num_of_components, ~] = size(Matrix);

b = ones(1,100)/100;
a = 1;
for j = 1 : num_of_components
    Matrix_filt(j,:) = filtfilt(b,a,Matrix(j,:)); 
end

end

