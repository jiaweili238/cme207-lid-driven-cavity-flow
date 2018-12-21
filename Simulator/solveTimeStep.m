function [ ux_new,uy_new, p ] = solveTimeStep( dx,dy,Re,dt,Nx,Ny,Lp,Up,ux_n,uy_n,U,V )

%% step 1 solve the first stage equation 
[ ux_star,uy_star ] = solverStage1( ux_n,uy_n,Nx,Ny,dx,dy,Re,dt,U,V );

%% stage 2 solve global pressure equation
[ p ] = solverStage2( ux_star,uy_star,dx,dy,Lp,Up,Nx,Ny,dt );

%% stage 3, update the new velocity
[ ux_new,uy_new ] = solverStage3( p,ux_star,uy_star,dx,dy,dt,Nx,Ny,U,V );


end

