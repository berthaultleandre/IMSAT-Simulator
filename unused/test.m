center=[0.5;0.5;0.5] ;
lim=1;
Lim=[-lim lim];

S=create_spacecraft(center, eye(3), dim);
plot3(S(:,1),S(:,2),S(:,3));
hold on
xlim(Lim)
ylim(Lim)
zlim(Lim)
plot3(0,0,0,'ro', 'MarkerSize', 5);

Rib=Rzyx(0,0,pi/5);
S=create_spacecraft(center, Rib, dim);
draw_frame(center, Rib, arrow_len, line_len);
plot3(S(:,1),S(:,2),S(:,3));
xlabel('x') 
ylabel('y') 
zlabel('z') 