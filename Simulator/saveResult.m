function saveResult( x,y,p,ux,uy,outPath,Re ,isSave )

N = length(x);
% save the pressure map
figure;
imagesc(p(2:end - 1,2:end - 1));
hold on;
title(['Pressure Field at t = 10 (Re = ' num2str(Re) ')']);
colorbar;
colormap jet;
shading interp;
streamslice(x(1:end -1) * length(x),y(1:end - 1)*length(y),ux(:,1:end-1),uy(1:end-1,:))
hold off;
if isSave == 1
    saveas(gca,[outPath '\Pressure_Re_' num2str(Re) '_N_' num2str(N)],'jpg');
end


% save the ux map 
figure;
imagesc(ux(2:end - 1,:));
title(['Ux Field at t = 10 (Re = ' num2str(Re) ')']);
colorbar;
colormap jet;
shading interp;
if isSave == 1
    saveas(gca,[outPath '\Ux_Re_' num2str(Re) '_N_' num2str(N)],'jpg');
end

% save the uy map
figure;
imagesc(uy(:,2:end - 1));
title(['Uy Field at t = 10 (Re = ' num2str(Re) ')']);
colorbar;
colormap jet;
shading interp;

if isSave == 1
    saveas(gca,[outPath '\Uy_Re_' num2str(Re) '_N_' num2str(N)],'jpg');
end
end

