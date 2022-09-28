function res_error = residueInd(arc_points, ind)
%residueInd - calculate error with certain kmeans result
%
% Syntax: res_error = residueInd(arc_points, ind)
%
% Long description
    k = max(ind);
    new_elli = zeros(k,5);
    new_points = cell(k,2);
    for i = 1:k
        group = find(ind==i);
    end
    %    Residuals_ellipse(arc_points{i,1},) 


end
