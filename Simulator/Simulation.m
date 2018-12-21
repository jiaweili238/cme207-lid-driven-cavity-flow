function Simulation(dx,dy,Re,outPath)

U0 = 10;
dt = dx^2 / (2 * U0);

x = 0:dx:1;
y = 0:dy:1;
t = 0:dt:10;

Nx = size(x,2) - 1;
Ny = size(y,2) - 1;


% generate the outer 
ux0 = zeros(Ny , Nx + 1);
uy0 = zeros(Ny + 1, Nx);

% BC for x velocity
U.S = 0;
U.W = 0;
U.E = 0;
U.N = 1;

% BC for y veloctity
V.S = 0;
V.W = 0;
V.E = 0;
V.N = 0;

% enforce the upper boundary condition, we define all the 
%[ ux0,uy0 ] = enforceVelocityBC( ux0,uy0,U,V );
%% step 2 solve stage one equations

% solve the x component equations
ux_n = ux0;
uy_n = uy0;
[ A,Lp,Up ] = stage2Matrix( Nx,Ny,dx,dy );

for i=1:length(t)
    [ ux_new,uy_new, p ] = solveTimeStep( dx,dy,Re,dt,Nx,Ny,Lp,Up,ux_n,uy_n,U,V );
    ux_n = ux_new;
    uy_n = uy_new;   
%      imagesc(ux_new);
%      colorbar;
%      colormap jet;
%      title(['Time = ' num2str(dt * i)],'FontSize',16);
%     pause(0.001);
end
saveResult( x,y,p,ux_new,uy_new,outPath,Re ,1 );
Name = ['data/Re_' num2str(Re) '_N_' num2str(Nx) '.mat'];
save(Name,'p','ux_new','uy_new','x','y');

end
