function flag = triangle_intersection(P1, P2)

    flag = true;

    for i=1:3
        
        p0 = P1(mod(i,3)+1,:);
        pF = P1(mod(i+1,3)+1,:);
        p3 = P1(mod(i+2,3)+1,:);
        
        if isSeperatingEdge(p0,pF,p3,P2)
            flag = false;
        end
    end

        for i=1:3
        
        p0 = P2(mod(i,3)+1,:);
        pF = P2(mod(i+1,3)+1,:);
        p3 = P2(mod(i+2,3)+1,:);
        
        if isSeperatingEdge(p0,pF,p3,P1)
            flag = false;
        end
    end
    
end



% --- Inputs
% p0 - (x,y) coordinate of first point on seperating edge
% pf - (x,y) coordinate of second point on seperating edge
% p3 - (x,y) coordinate of third point on triangle
% P2 - the other triangle

% --- Output
% flag - boolean, 


function flag = isSeperatingEdge(p0,pF,p3,P2)

    flag = true;
    
    % y = m*x + b
    m = ( pF(1,2) - p0(1,2) )/ (pF(1,1) - p0(1,1));
    b = pF(1,2) - m*pF(1,1);
    
    p3Side = (p3(1,2) > m*p3(1,1) + b);
        
    for row = 1:size(P2)
        if (P2(row,2) >= m*P2(row,1) + b) == p3Side
            flag = false;
        end
    end
end

