groups = cellfun(@(x) func(x), frames, 'UniformOutput', false);
original_arcs = cell(size(groups{end}));
groupLevel = 5;

for i = 1:numel(groups{end})
    
    original_arcs{i} = getOrigArcs(i, groups, groupLevel);
    
end

%% draw the original arcs in the same color if they are in the same group
im = imread(frames{1}.sourceimg);
imshow(im);
hold on;
for i = 1:numel(groups{end})
    
    color = rand(1,3);
    for j = 1:numel(original_arcs{i})
        drawEllipseHelper(frames{1}.elli(original_arcs{i}(j),:), color);
    end
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

function drawEllipseHelper(ellipses_para, color)
    % if ellipses_para is empty, return
    if isempty(ellipses_para)
        return;
    end

    th = 0:pi / 180:2 * pi;
    Semi_major = ellipses_para(3);
    Semi_minor = ellipses_para(4);
    x0 = ellipses_para(1);
    y0 = ellipses_para(2);
    Phi = ellipses_para(5);
    x = x0 + Semi_major * cos(Phi) * cos(th) - Semi_minor * sin(Phi) * sin(th);
    y = y0 + Semi_minor * cos(Phi) * sin(th) + Semi_major * sin(Phi) * cos(th);
    plot(x, y, 'Color', color, 'LineWidth', 2);
    return;
end