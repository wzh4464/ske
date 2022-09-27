function ind = cocluster(input,k)
    [~,out_num] = size(input');
    cor = zeros(out_num);
    for i = 1 : out_num
        for j = 1 : out_num
            cor(i,j) = Correlation(input(i,:),input(j,:));
        end
    end
    [u,s,~]=svd(cor);
    R = u*s.^(1/2);
    [ind,~,~] = kmeans(R,k);
end