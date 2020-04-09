clear all
global app


app.N = 200;
app.robot_num = 50;
app.known_num = 25;

app.A = zeros(app.robot_num, app.robot_num);

app.robot_position = zeros(2, app.robot_num);

app.robot_state = zeros(3, app.robot_num, app.N);
app.robot_real_state = zeros(3, app.robot_num, app.N);

app.robot_distance = zeros(app.robot_num, app.robot_num, app.N);

app.RSS_radius = 15;


app.robot_RSS_radius = zeros(1, app.robot_num);
app.robot_RSS_radius(:) = app.RSS_radius;

for i = 1:size(app.robot_position,2)
    app.robot_position(:,i) = [rand()*50, rand()*50]';
    app.robot_state(:,i,1) = [rand()*50, rand()*50, rand()]';
end






a = figure(1);
clf;
axe = axes;
set(a, 'Children', axe);
pls = cell(3,1);
pls{1} = plot(axe, 0,0, 'd', 'Color', 'k', 'MarkerSize', 3, 'LineWidth', 5); hold on;
pls{2} = plot(axe, 0,0, 'o', 'Color', 'c', 'MarkerSize', 3, 'LineWidth', 5); hold on;
pls{3} = viscircles(app.robot_position(:,1:app.known_num)', app.robot_RSS_radius(1:app.known_num)'); hold on;
pls{4} = plot(axe, 0,0, 'd', 'Color', 'r', 'MarkerSize', 3, 'LineWidth', 5);

grid(axe, 'on');
axis(axe, 'equal');
set(axe, 'XLim', [-10,60]);
set(axe, 'YLim', [-10,60]);

app.h_legend = [pls{1} pls{2} pls{3}];
legend(app.h_legend,'known','unkown','RSS_ circle', 'FontSize', 15);
xlabel(axe,'X (m)'); ylabel(axe,'Y (m)');
title('position');

for i = 2:app.N
   for j = 1:size(app.robot_real_state,2) 
       
   end
end

for i = 2:app.N
    
    
    for j = 1:size(app.robot_state,2)
      app.robot_real_state(:,j,i) = dynamics(app.robot_state(:,j,i-1), [0,0], 0.1, [0.05, 0.05, 0.05]);
      app.robot_state(:,j,i) = dynamics(app.robot_state(:,j,i-1), [0, 0], 0.1, [0.1 0.1 0.1]);
      
    end
    for j = 1:app.robot_num
       for k = 1:app.robot_num
            if j == k
               continue; 
            else
                d = app.robot_state(1:2,j,i)-app.robot_state(1:2,k,i);
                d = norm(d);
               
                if d > 30
                   app.robot_distance(j,k,i) = 0; 
                end
                app.robot_distance(j,k,i) = norm(d);
            end
       end
    end
    
    
    
    
    
    
    
    %% plot
    set(pls{1}, 'XData', app.robot_state(1,1:app.known_num,i));
    set(pls{1}, 'YData', app.robot_state(2,1:app.known_num,i));
    set(pls{2}, 'XData', app.robot_state(1,app.known_num+1:app.robot_num,i));
    set(pls{2}, 'YData', app.robot_state(2,app.known_num+1:app.robot_num,i));
    set(pls{3}.Children(1), 'XData', 0);    set(pls{3}.Children(1), 'YData', 0);
    set(pls{3}.Children(2), 'XData', 0);    set(pls{3}.Children(2), 'YData', 0);
    %     pls{3} = viscircles(app.robot_position', app.robot_RSS_radius');
    pls{3} = viscircles(app.robot_state(1:2,1:app.known_num,i)', app.robot_RSS_radius(1:app.known_num)');
    drawnow;
    
    pause(0.1);
end

