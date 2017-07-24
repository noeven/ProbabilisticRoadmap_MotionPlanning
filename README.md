# Probabilistic-Roadmap-Configuration-Space-Navigation

## Overview
Matlab project to naviagate a 6 armed robot through an obstacle filled environment to a desired end configuration. The Probabalistic Road Map method is used for configuration space graph construction. The created graph is then searched using Dijkstra's shortest path algorithm to create a route through which the robot can travel to reach it's end goal. The GUI and frame work was provided by the University of Pennsylvania's Computational Motion Planning ponline Mooc.

## Componenents
- **Triangle Intersection Algorithm**: Determines if two triangles interesect. This method is used to determine if a proposed configuration space would collide with any obstacles. This is done by breaking the arm joints and the obstacles into triangles and iterating through all to see if there is an intersection.
- **PRM** Generates the designated number of random samples and connects each one to the specified amount of closest neighbors
- **Dijkstra Search** Searches the provided graph for the shortest path between the start and end configuration nodes. 

## Demo

`start_config =  [0  0   0   -45   45   0]';`<br>
`end_config =    [-35  -30   -25   20   20   -20]';`
 
![](https://github.com/JeremySMorgan/Probabilistic-Roadmap-Configuration-Space-Navigation/blob/master/prm_1.gif)