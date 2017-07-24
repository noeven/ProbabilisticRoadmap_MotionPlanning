%
% SixLinkPRMScript.
%
 
 
%% Drawing the robot
clc
clear
close all
figure;
%fprintf('\n /----------------/ \n\n');
 
% The SixLinkRobot function computes layout of all of the links in the
% robot as a function of the 6 configuration space parameters. You can
% adjust these sixe numbers to see what happens.

%start_config = [240 120 240 120 240 60]'
start_config =  [0  0   0   -45   45   0]';
end_config =    [-35  -30   -25   20   20   -20]';

fv = SixLinkRobot (start_config); 
fv2 = SixLinkRobot (end_config);
 
p2 = patch(fv2);
p2.FaceColor = 'green';
p2.EdgeColor = 'none';

p = patch (fv);
p.FaceColor = 'red';
p.EdgeColor = 'none';
 
sz = 30;
axis equal;
axis (sz*[-1 1 -1 1]);
 
%% Add obstacles
obstacle = boxFV(10, 20, 10, 20);
obstacle = appendFV (obstacle, boxFV(-20, 0, -20, -10));
obstacle = appendFV (obstacle, transformFV(boxFV(-10, 10, -10, 10), 30, [-20 20]));
 
patch (obstacle);
 
%% Build roadmap
nsamples = 100;
neighbors = 10;
 
t = cputime;
roadmap = PRM (@()(RandomSampleSixLink(obstacle)), @DistSixLink, @(x,y)(LocalPlannerSixLink(x,y,obstacle)), nsamples, neighbors);
cputime-t
 
%% Add nodes
 
roadmap2 = AddNode2PRM (start_config, roadmap, @DistSixLink, @(x,y)(LocalPlannerSixLink(x,y,obstacle)), neighbors);
roadmap2 = AddNode2PRM (end_config, roadmap2, @DistSixLink, @(x,y)(LocalPlannerSixLink(x,y,obstacle)), neighbors);

%% Plan a route
 
route = ShortestPathDijkstra(roadmap2.edges, roadmap2.edge_lengths, nsamples+1, nsamples+2)
 
%% Plot the trajectory
 
for i = 2:length(route)
    x1 = roadmap2.samples(:,route(i-1));
    x2 = roadmap2.samples(:,route(i));
    
    delta = x2 - x1;
    
    t = delta > 180;
    delta(t) = delta(t) - 360;
    
    t = delta < -180;
    delta(t) = delta(t) + 360;
    
    n = ceil(sum(abs(delta)) / 10);
    
    
    for j = 0:n
        
        
        pause(.05);
        
        x = mod(x1 + (j/n)*delta, 360);
        
        fv = SixLinkRobot (x);
        
        p.Vertices = fv.vertices;
        
        drawnow;
        
        if (CollisionCheck(fv, obstacle))
            fprintf (1, 'Ouch\n');
        end
        
    end
    
end
