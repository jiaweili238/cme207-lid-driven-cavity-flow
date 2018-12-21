%% CME207 porject
%% part 2
%% Solve incompressible N-S equation

close;
clear;
%% step 1 initialization
outPath = 'result';

Re = [1000];
dx = [ 1/80 ];
dy = [ 1/80];

for i = 1:length(Re)
    for j = 1:length(dx)
        Simulation(dx(j),dy(j),Re(i),outPath)
    end
end
    
