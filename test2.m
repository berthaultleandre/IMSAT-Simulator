  R = 1; % earth radius in km
  
    T_e = 86164.1; %earth period (1 day) [s]
    w_e_deg = 360/T_e; %angular velocity [deg/s]
latspacing = 10; 
lonspacing = 20; 
% lines of longitude: 
t=2;
dtheta=1000*w_e_deg*t;
[lon1,lat1] = meshgrid(-180+dtheta:lonspacing:180+dtheta,linspace(-90,90,300)); 
[x1,y1,z1] = sph2cart(lon1*pi/180,lat1*pi/180,R); 
earth=plot3(x1,y1,z1,'-','color',0.5*[1 1 1]);
hold on
% lines of latitude: 
[lat2,lon2] = meshgrid(-90:latspacing:90,linspace(-180,180,300)); 
[x2,y2,z2] = sph2cart(lon2*pi/180,lat2*pi/180,R); 
plot3(x2,y2,z2,'-','color',0.5*[1 1 1])
hold on

[X,Y,Z] = sphere(100); 
surf(X*R*.99,Y*R*.99,Z*R*.99,'facecolor','w','edgecolor','none')

C = load('borderdata.mat');
for k = 1:246
   [xtmp,ytmp,ztmp] = sph2cart(deg2rad(C.lon{k}),deg2rad(C.lat{k}),R);
   plot3(xtmp,ytmp,ztmp,'k');
end