function flag = triangle_intersection(P1, P2)
% triangle_test : returns true if the triangles overlap and false otherwise
    
    flag = false; 
    if triangle_inside(P1,P2)
        flag = true;
    end
    
    for i = 1:3
        for j = 1:3
            if i >= 3
                ii = 1;
            else
                ii = i+1;
            end
            if j >= 3
                jj = 1;
            else
                jj = j+1;
            end

            x1 = P1(i ,1);
            x2 = P1(ii,1);
            y1 = P1(i ,2);
            y2 = P1(ii,2);

            x3 = P2(j ,1);
            x4 = P2(jj,1);
            y3 = P2(j ,2);
            y4 = P2(jj,2);      

            if line_intersection(x1, x2, x3, x4, y1, y2, y3, y4)== 1
                flag = true;
            end
        end
    end

end

function [ intersection ] = line_intersection( x1, x2, x3, x4, y1, y2, y3, y4)

    numera = (x4-x3) * (y1-y3) - (y4-y3) * (x1-x3);
    denom  = (y4-y3) * (x2-x1) - (x4-x3) * (y2-y1);
    numerb = (x2-x1) * (y1-y3) - (y2-y1) * (x1-x3);

    if abs(numera) < eps && abs(numerb) < eps && abs(denom) < eps
        intersection = true;
    else
        % test for parrellel case 
        if abs(denom) < eps
            intersection = false;
        else
            % test for an intersection along segments 
            mua = numera / denom;
            mub = numerb / denom;
            if mua < 0 || mua > 1 || mub < 0 || mub > 1
                intersection = false;
            else
                intersection = true;
            end
        end
    end   
end


function [ inside ] = triangle_inside( P1, P2 )
    inside = false;
    B =[P2(1,1) P2(1,2) 1;
        P2(2,1) P2(2,2) 1;
        P2(3,1) P2(3,2) 1];
    
    B1 =[P1(1,1) P1(1,2) 1;
        P2(2,1) P2(2,2) 1;
        P2(3,1) P2(3,2) 1];

    B2 =[P2(1,1) P2(1,2) 1;
        P1(1,1) P1(1,2) 1;
        P2(3,1) P2(3,2) 1];

    B3 =[P2(1,1) P2(1,2) 1;
        P2(2,1) P2(2,2) 1;
        P1(1,1) P1(1,2) 1];
    
    b = abs(det(B1)/2) + abs(det(B2)/2) + abs(det(B3)/2);
    
    if abs(det(B)/2) == b
        inside = true;
    end
end

