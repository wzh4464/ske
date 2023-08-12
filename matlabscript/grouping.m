groups = cellfun(@(x) func(x), frames, 'UniformOutput', false); 
original_arcs = cell(size(groups{end}));
groupLevel = 5;

for i = 1:numel(groups{end})
    
    original_arcs{i} = getOrigArcs(i, groups, groupLevel);
    
end

function orig = getOrigArcs(index, groups, level)

    if level == 1
        orig = cell2mat(groups{1}(index));
    else
        subindex = cell2mat(groups{level}(index));
        orig_tmp = cell(size(subindex));
        for i = 1:numel(subindex)
            orig_tmp{i} = getOrigArcs(subindex(i), groups, level-1);
        end
        orig = cell2mat(orig_tmp);
    end

end
