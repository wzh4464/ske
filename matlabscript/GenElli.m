% @Author: WU Zihan
% @Date:   2022-10-05 00:25:02
% @Last Modified by:   WU Zihan
% @Last Modified time: 2022-10-05 16:03:13
function [elli,cframe] = GenElli(datapath, filename, postfix)

    arcs = rawArc(datapath, filename, postfix);
    cframe = frame(arcs);
    lastSum = 100000000;
    k = length(arcs.points);
    round_num = 0;
    k = floor(k / 2);

%     while lastSum - cframe.resSum > 0.2
%         lastSum = cframe.resSum;
%         round_num = round_num + 1;
%         cframe = coclusterFrame(cframe, k);
%         k = floor(k / 2);
%     end
    while k > 1
%         lastSum = k;
        round_num = round_num + 1;
        cframe = coclusterFrame(cframe, k);
        k = floor(k / 2);
    end

    cframe.showAllElli();
    elli = cframe.elli;

end
