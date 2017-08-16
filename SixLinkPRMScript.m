close all, clear all
figure(1);

start_config = [240 120 240 120 240 60]
end_config = [330 30 0 0 0 180]
fv = SixLinkRobot (start_config);
fv2 = SixLinkRobot (end_config);

p = patch (fv);
p.FaceColor = 'red';
p.EdgeColor = 'none';

p2 = patch(fv2);
p2.FaceColor = 'green';
p2.EdgeColor = 'none';

sz = 28;
axis equal;
axis (sz*[-1 1 -1 1]);

obstacle = boxFV(-18, 10, 13, 11);
obstacle = appendFV (obstacle, boxFV(-14, -5, -10, -19));
obstacle = appendFV (obstacle, transformFV(boxFV(-6, 6, -5, 4), 45, [15 -15]));

patch (obstacle);

%% Build roadmap

nsamples = 20;
neighbors = 5;

roadmap = PRM (@()(RandomSampleSixLink(obstacle)), @DistSixLink, @(x,y)(LocalPlannerSixLink(x,y,obstacle)), nsamples, neighbors);

%% Add start, end nodes
roadmap2 = AddNode2PRM (start_config', roadmap, @DistSixLink, @(x,y)(LocalPlannerSixLink(x,y,obstacle)), neighbors);
roadmap2 = AddNode2PRM (end_config', roadmap2, @DistSixLink, @(x,y)(LocalPlannerSixLink(x,y,obstacle)), neighbors);

%% Plan a route

route = ShortestPathDijkstra(roadmap2.edges, roadmap2.edge_lengths, nsamples+1, nsamples+2)

%% Plot the trajectory

pause(.5);
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
        
        x = mod(x1 + (j/n)*delta, 360);
        
        fv = SixLinkRobot (x);
        
        p.Vertices = fv.vertices;
        
        drawnow;
        
        if (CollisionCheck(fv, obstacle))
%            fprintf (1, 'Ouch\n');
        end
        
    end
    
end
