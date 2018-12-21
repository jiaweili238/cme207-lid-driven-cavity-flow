function [ A,Lp,Up ] = stage2Matrix( Nx,Ny,dx,dy )

% first the pressure matrx should be Ny * Nx.
Ngrid = Nx * Ny;
d = [-Nx -1 0 1 Nx];
B = zeros(Ngrid,5);

a0 = zeros(Nx,1);
a0(1:end - 1) = 1 / dx^2;
a1 = repmat(a0,Ny,1);

% matrix term in y direction
B(1:(Ngrid - (Nx)) , 1 ) = 1 / dy^2;
B((Nx + 1):end , 5 ) = 1 / dy^2;
% enforce the boudary condition for the upper wall
B((Nx + 1):2 * Nx , 5 ) = 1 / (0.75 * dy^2);

% matrix term in x direction
B(:,2) = a1;
B(:,4) = [0;a1(1:end - 1)];


B(:,3) = 0;
%B(:,3) = -sum(B,2);
% enforce the boudary condition for the upper wall.
%B(1:Nx,3 ) = B(1:Nx,3 ) - 2 / dy^2;
% we need to minus sum column 2 and column 3.
%B(1:Nx,3) = 0 ; 


A = spdiags(B,d,Ngrid,Ngrid);
A(1,1) = - A(1,2) - 4/(dy^2);
for i = 2:Nx - 1
    A(i,i) = - A(i,i - 1) - A(i ,i + 1) - 4/(dy^2);
end
A(Nx,Nx) = - A(Nx ,Nx - 1) - 4/(dy^2);
for i =Nx + 1:size(A,2)
    A(i,i) = -sum(A(i,:));
end
[Lp,Up] = lu(A);

end

