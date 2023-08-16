%% draw the original arcs in the same color if they are in the same group
im = imread(frames{1}.sourceimg);
imshow(im);
hold on;
color = [1 0 0; 0 0 1; 0 1 0];
for j = 1:3
    drawEllipseHelper(elli(j,:), color(j,:));
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
    plot(x, y, 'Color', color, 'LineWidth', 5);
    return;
end