function [intersection] = triangle_intersection(P1, P2)
    % triangle_test : returns true if the triangles overlap and false otherwise
    % triangle_inside working
    % line_intersection not working

    intersection = false; 
    
    % P1 =
    %   2.6108   -5.4106
    %   6.7056   -2.3720
    %   2.1840   -4.5062

    %P2 =
    %   -18    13
    %   10    11
    %   -18    11

    t1p1 = P1(1,1:2);
    t1p2 = P1(2,1:2);
    t1p3 = P1(3,1:2);
    t2p1 = P2(1,1:2);
    t2p2 = P2(2,1:2);
    t2p3 = P2(3,1:2);
   
    % Check to see that triangles are not insde one another
    if triangle_inside( t1p1,t1p2,t1p3,t2p1,t2p2,t2p3 )
        intersection = true;
    end
    
    if ~intersection
        % iterate through all point combinations. 9 total
        for i = 1:3
            for j = 1:3
                i_temp = get_i_temp(i);
                j_temp = get_j_temp(j);

                s1x1 = P1(i ,1);
                s1x2 = P1(i_temp,1);
                s1y1 = P1(i ,2);
                s1y2 = P1(i_temp,2);

                s2x1 = P2(j,1);
                s2x2 = P2(j_temp,1);
                s2y1 = P2(j ,2);
                s2y2 = P2(j_temp,2);       

                if line_intersection(s1x1, s1x2, s2x1, s2x2, s1y1, s1y2, s2y1, s2y2)
                    intersection = true;
                end
            end
        end
    end
end


function j_temp = get_j_temp(j)
    if j >= 3
        j_temp= 1;
    else
        j_temp = j+1;
    end
end

function i_temp = get_i_temp(i)
    if i >= 3
        i_temp = 1;
    else
        i_temp = i+1;
    end
end


function [inside] = triangle_inside( t1p1,t1p2,t1p3,t2p1,t2p2,t2p3)
    % triangle_inside returns if P1 is inside P2. uses 'same side'
    % technique
    
    inside = false;
    
    if point_inside(t1p1,t2p1,t2p2,t2p3) && point_inside(t1p2, t2p1,t2p2,t2p3) && point_inside(t1p2, t2p1,t2p2,t2p3)
        inside = true;
    end

    if point_inside(t2p1,t1p1,t1p2,t1p3) && point_inside(t2p2,t1p1,t1p2,t1p3) && point_inside(t2p3,t1p1,t1p2,t1p3)
        inside = true;
    end
end

function [inside] = point_inside(p, a, b, c)
    inside = same_side(p,a, b,c) && same_side(p,b, a,c) && same_side(p,c, a,b);   
end

function [same_side] = same_side( p1, p2, a,b)
    % Returns whether point p1 and p2 are on the same side of the line
    % defined by segment between a and b

    same_side = false;
        
    p1 = [p1(1,1), p1(1,2), 0];
    p2 = [p2(1,1), p2(1,2), 0];

    a = [a(1,1), a(1,2), 0];
    b = [b(1,1), b(1,2), 0];
    
    cp1 = cross(b-a, p1-a);
    cp2 = cross(b-a, p2-a);
    
    if dot(cp1, cp2) >= 0
       same_side = true;
    end
end


