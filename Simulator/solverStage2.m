function [ p ] = solverStage2( ux_star,uy_star,dx,dy,Lp,Up,Nx,Ny,dt )
% construct the right hand side first order derivatives.
duxdx = ( ux_star(:,2:end) - ux_star(:,1:end-1) ) / (dx);
duydy = ( uy_star(2:end,:) - uy_star(1:end-1,:) ) / (dy);

% calculate the right handside of the pressure equation
b = (duxdx + duydy) / dt;
b = reshape(b',[(Nx)*(Ny),1]);

% solve the pressure field
z  = Lp \ b;
p = Up \ z;
p = reshape(p,[Nx , Ny]);
p = p';

% % add the boudary condition for the pressure field.
% p = [p(:,1) p p(:,end)];
% p = [ - p(1,:); p ;p(end,:)];

end

