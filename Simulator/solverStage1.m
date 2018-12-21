function [ ux_star,uy_star ] = solverStage1( ux,uy,Nx,Ny,dx,dy,Re,dt,U,V )

% calculate the first order derivatives for the inner domain
% we need the dudx and dudy


% calculate uxn for the inner domian
uxn = ux(:,2:end-1);

%calculate uyn for the inner domain
uy1 = uy(1:end - 1,1:end - 1);
uy2 = uy(1:end - 1,2:end);
uy3 = uy(2:end ,1:end - 1);
uy4 = uy(2:end ,2:end );
uyn = (uy1 + uy2 + uy3 + uy4) / 4;


% first calculate first order derivative and enforce the boundary
% conditions
%duxdx = ( ux(:,3:end) - ux(:,1:end-2) ) / (2 * dx);

% i is the index for the colomn
for i = 1:Ny
    % j is the index for the row
    for j = 1:Nx - 1
        if uxn(i,j) > 0
            duxdx(i,j) = (ux(i,j + 1) - ux(i,j ) ) / dx;
        else
            duxdx(i,j) = (ux(i,j + 2) - ux(i,j + 1) ) / dx;
        end
    end
end

% consider the first row
for j = 1:Nx - 1
    if uyn(1,j) > 0
        duxdy(1,j) = (uxn(1,j) - 1 ) / (0.5 * dy) ;
    else
        duxdy(1,j) = (ux(2,j) - ux(1,j) ) / dy ;
    end
end

for i = 2:Ny -1
    for j = 1:Nx - 1
        if uyn(i,j) > 0
            duxdy(i,j) = (uxn(i ,j ) - uxn(i - 1,j ) ) / dy ;
        else
            duxdy(i,j) = (uxn(i+ 1 ,j ) - uxn(i,j ) ) / dy ;
        end           
    end
end

for j = 1:Nx - 1
    if uyn(Ny,j) > 0
        duxdy(Ny,j) = (uxn(Ny,j) - uxn(Ny - 1,j) ) / dy ;
    else
        duxdy(Ny,j) = (0 - uxn(Ny,j) ) / (0.5 * dy) ;
    end
end
% consider the inner domain


% % consider the bottom rwo
% duxdy = zeros(Ny, Nx-1);
% duxdy(2:end-1,:) = ( ux(3:end,2:end-1) - ux(1:end-2,2:end-1) ) / (2 * dy);
% % enforce the boundary condition for the upper and lower wall.
% duxdy(1,:) = (-4 * ones(1,Nx - 1) + 3 * ux(1,2:end - 1) + ux(2,2:end - 1)) / (3 * dy);
% duxdy(end,:) = ( - 3 * ux(end,2:end - 1) - ux(end - 1,2:end - 1)) / ( 3 * dy);

% first we need the modified matrix ux(i-1,j);
% duxdx = ( ux(2:end-1,3:end) - ux(2:end-1,1:end-2) ) / (2 * dx);
% duxdy = ( ux(3:end,2:end-1) - ux(1:end-2,2:end-1) ) / (2 * dy);

% calculate the second order derivatives
d2uxdx2 = (ux(:,1:end-2) - 2 * ux(:,2:end-1) + ux(:,3:end)) / dx^2 ; 
d2uxdy2 = zeros(Ny,Nx - 1);
d2uxdy2(2:end - 1,:) = (ux(1:end-2,2:end-1) - 2 * ux(2:end-1,2:end-1) + ux(3:end,2:end-1)) / dy^2 ; 

%enforce the boundary condition for upper and lower wall.
d2uxdy2(1,:) = (2 *ones(1,Nx-1) + ux(2,2:end - 1) - 3 * ux(1,2:end - 1)) / (0.75 * dy^2);
d2uxdy2(end,:) = (  ux(end - 1,2:end - 1) - 3 * ux(end,2:end - 1)) / (0.75 * dy^2);


% update velocity
ux_star = uxn - dt * (uxn .* duxdx + uyn .* duxdy) + dt / Re * (d2uxdx2 + d2uxdy2);

% solve the y component equations
% first, we need to calculate duydx and duydy
% calculate the duydy, this is very straight forward.

% calculate uyn
uyn = uy(2:end -1,:);
% calculate uxn for the inner domian
ux1 = ux(1:end -1,1:end - 1);
ux2 = ux(1:end -1,2:end );
ux3 = ux(2:end ,1:end - 1);
ux4 = ux(2:end ,2:end );
uxn = (ux1 + ux2 + ux3 + ux4) / 4;


for j = 1:Nx
    for i = 1: Ny -1
        if uyn(i,j) > 0
            duydy(i,j) = ( uy(i +1,j) - uy(i ,j) ) / (dy);
        else
            duydy(i,j) = ( uy(i +2,j) - uy(i + 1 ,j) ) / (dy);
        end
    end
end

%duydy = ( uy(3:end,:) - uy(1:end-2,:)) / (2 * dy);
% calculate the duydx

% consider the first column

for i = 1:Ny - 1
    if uxn(i,1) > 0
        duydx(i,1) = ( uyn(i,1) - 0 ) / (0.5 * dx);
    else
        duydx(i,1) = ( uyn(i,2) - uyn(i,1) ) / (dx);
    end
end

% consider the inner domain
for j = 2: Nx - 1
    for i = 1:Ny - 1
        if uxn(i,j) > 0
            duydx(i,j) = ( uyn(i,j) - uyn(i,j- 1) ) / (dx);
        else
            duydx(i,j) = ( uyn(i,j + 1) - uyn(i,j) ) / (dx);
        end
    end
end
% consider the last colume
for i = 1:Ny - 1
    if uxn(i,Nx) > 0
        duydx(i,Nx) = ( uyn(i,Nx) - uyn(i,Nx - 1) ) / (dx);
    else
        duydx(i,Nx) = ( 0 - uyn(i,Nx) ) / (0.5 * dx);
    end
end

% duydx = zeros(Ny - 1,Nx);
% duydx(:,2:end - 1) = ( uy(2:end-1,3:end) - uy(2:end-1,1:end-2) ) / (2 * dx);
% % enforce the boundary condition for left and right wall
% duydx(:,1) = (uy(2:end-1,2) + 3 * uy(2:end-1,1)) / (3 * dx);
% duydx(:,end) = ( - uy(2:end-1,end-1) + - 3 * uy(2:end-1,end)) / (3 * dx);

% enforce the boundary condition for duydx
% ************ to be done later

% duydx = ( uy(2:end-1,3:end) - uy(2:end-1,1:end-2) ) / (2 * dx);
% duydy = ( uy(3:end,2:end-1) - uy(1:end-2,2:end-1) ) / (2 * dy);

% second order derivatives for uy
d2uydy2 = (uy(1:end-2,:) - 2 * uy(2:end-1,:) + uy(3:end,:)) / dy^2 ; 

d2uydx2 = zeros(Ny - 1,Nx);
% calculate the inner part of the derivatives.
d2uydx2(:,2:end-1) = (uy(2:end-1,1:end-2) - 2 * uy(2:end-1,2:end-1) + uy(2:end-1,3:end)) / dx^2 ;

%%%%%%% enforce boundary condition for second order derivative
d2uydx2(:,1) =  (uy(2:end-1,2) - 3 * uy(2:end-1,1)) / (0.75 * dx^2);
d2uydx2(:,end) =  (uy(2:end-1,end-1) - 3 * uy(2:end-1,end)) / (0.75 * dx^2);

uy_star = uyn - dt * (uxn .* duydx + uyn .* duydy) + dt / Re * (d2uydx2 + d2uydy2);


% add zeros to the boundary and enforce the boundary conditions
ux_star = [zeros(Ny,1) ux_star zeros(Ny ,1)];

uy_star = [zeros(1,Nx) ; uy_star; zeros(1,Nx)];
% the final step is to enforce the velocity boundary conditions
%[ ux_star,uy_star ] = enforceVelocityBC( ux_star,uy_star,U,V );



end

