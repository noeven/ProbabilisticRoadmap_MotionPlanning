function [ intersection ] = line_intersection( s1x1, s1x2, s2x1, s2x2, s1y1, s1y2, s2y1, s2y2)

    intersection = false;

    numer_a = (s2x2-s2x1) * (s1y1-s2y1) - (s2y2-s2y1) * (s1x1-s2x1);
    denom  = (s2y2-s2y1) * (s1x2-s1x1) - (s2x2-s2x1) * (s1y2-s1y1);
    numer_b = (s1x2-s1x1) * (s1y1-s2y1) - (s1y2-s1y1) * (s1x1-s2x1);

    if abs(numer_a) < eps && abs(numer_b) < eps && abs(denom) < eps
        intersection = true;
    else
        % test for parrellel case 
        if abs(denom) < eps
            intersection = false;
        else
            % test for an intersection along segments 
            mua = numer_a / denom;
            mub = numer_b / denom;
            if mua < 0 || mua > 1 || mub < 0 || mub > 1
                intersection = false;
            else
                intersection = true;
            end
        end
    end   
end