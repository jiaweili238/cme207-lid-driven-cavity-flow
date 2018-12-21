%% %% CME207 porject
%% PArt 2 problem 1
%% generate the grid file.

dx = 0.2;
dy = 0.25;

x = 0:dx:1;
y = 0:dy:1;


%% step 1 first plot all the horizontal line
for j = 1:length(y)
    plot([0 1],[y(j) y(j)],'k');
    hold on;
end
% second plot all the vertical line
for j = 1:length(x)
    plot([x(j) x(j)],[0 1],'k');
    hold on;
end

%% step 2 plot all the pressure point
for i = 1:length(y) - 1
    % plot th pressure points in every raw
    %plot(x(1) - 0.5 * dx, y(i) + 0.5 * dy,'b*');
    for j = 1:length(x) - 1
        xx = x(j) + 0.5 * dx;
        yy = y(i) + 0.5 * dy;
        h1 = plot(xx,yy,'b*');       
    end
end

% plot(x(1) - 0.5 * dx, y(1) - 0.5 * dy,'b*');
% for j = 1:length(x)
%     plot(x(j) + 0.5 * dx, y(1) - 0.5 * dy,'b*');
% end

%% step 3 plot the ux in the interface
for i = 1:length(y) - 1
    for j = 1:length(x)
        h2 = quiver(x(j) , y(i) + 0.5 * dy,0.05,0,'r','LineWidth',1.5,'MaxHeadSize',2);       
    end
end
% i = length(y);
% for j = 1:length(x)
%     h2 = quiver(x(j) , y(i) + 0.5 * dy,0.05,0,'r','LineWidth',1.5,'MaxHeadSize',2);       
% end

%% step 4, plot the uy in the interface
for j = 1:length(x) - 1
    for i = 1:length(y) 
        h3 = quiver(x(j) + 0.5 * dx , y(i),0, - 0.05,'k','LineWidth',1.5,'MaxHeadSize',2);
    end
end
% j = 1;
% for i = 1:length(y) 
%     h3 = quiver(x(j) - 0.5 * dx , y(i),0, - 0.05,'k','LineWidth',1.5,'MaxHeadSize',2);
% end


legend([h1,h2,h3],{'pressure','x-velocity','y-velocity'});

axis([-0.2 1.3 -0.2 1.3]);