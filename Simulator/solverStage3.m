function [ ux_new,uy_new ] = solverStage3( p,ux_star,uy_star,dx,dy,dt,Nx,Ny,U,V )

dpdx = ( p(:,2:end ) - p(:,1:end-1) ) / (dx);
dpdy = ( p(2:end,:) - p(1:end-1,:) ) / (dy);

% update the velocity
ux_new = ux_star;
uy_new = uy_star;

ux_new(:,2:end - 1) = ux_star(:,2:end-1) - dt * dpdx;
uy_new(2:end-1,:) = uy_star(2:end-1,:) - dt * dpdy;

% % add zeros to the boundary conditions
% ux_new = [zeros(Ny,1) ux_new zeros(Ny ,1)];
% ux_new = [zeros(1,Nx + 1) ; ux_new; zeros(1,Nx + 1)];
% 
% uy_new = [zeros(Ny - 1,1) uy_new zeros(Ny - 1,1)];
% uy_new = [zeros(1,Nx + 2) ; uy_new; zeros(1,Nx + 2)];
% 
% % enforce the boundary conditions
% [ ux_new,uy_new ] = enforceVelocityBC( ux_new,uy_new,U,V );

end

