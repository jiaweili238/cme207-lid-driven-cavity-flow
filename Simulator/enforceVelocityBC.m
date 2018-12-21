function [ ux,uy ] = enforceVelocityBC( ux,uy,U,V )

% enforce the x  boundary conditions for left and write boundary
ux(2:end - 1,1) = U.W;
ux(2:end - 1,end) = U.E;
% enforce the x  boundary conditions for upper and bottom boundary
ux(1,1:end) = 2 * U.N - ux(2,1:end);
ux(end,1:end) = 2 * U.S - ux(end - 1,1:end);

% enforce the y boundary condition for upper and bottom boundary
uy(1,2:end - 1) = V.N;
uy(end,2:end - 1) = V.S;

% enforce the y boundary condition for left and right boundary
uy(1:end,1) = 2 * V.W - uy(1:end,2);
uy(1:end,end) = 2 * V.E - uy(1:end,end - 1);

end

