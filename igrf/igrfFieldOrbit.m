%calculate the magnetic field using the igrf11 model
clear all;
close all;
disp("Calculating the magnetic field using IGRF11...")
G = 6.67428e-11; %gravity constant [m^3kg^-1s^-2]
m_e = 5.9742e24; %earth mass [kg]
g_0 = G*m_e; %earth gravitation coefficient [m^3s^-2]
T_e = 86400; % earth period (1 day) [s]
w_e = 2*pi/T_e; %angular velocity [rad/s]
lon0 = w_e*180/pi;
%300km
alt300 = 6371.2e3 + 300e3;
w_s300 = sqrt(g_0/(alt300^3));
lat300_0 = w_s300*180/pi;
%500km
alt500 = 6371.2e3 + 500e3;
w_s500 = sqrt(g_0/(alt500^3));
lat500_0 = w_s500*180/pi;
%800km
alt800 = 6371.2e3 + 800e3;
w_s800 = sqrt(g_0/(alt800^3));
lat800_0 = w_s800*180/pi;
T_s = 2*pi/w_s500;
T_s300 = 2*pi/w_s300;
T_s500 = 2*pi/w_s500;
T_s800 = 2*pi/w_s800;
%w_s300*T_s300=¬2pi
%2*pi/(w_e*T_s)=15.2450 orbits
%300km
    for i = 1:T_s300*15
    lon = lon0*i;
    lat300 = lat300_0*i;
    B300 = igrf(datenum(2020,12,27,12,0,i),lat300,lon,alt300*10^-3)*10^-9;
    box300(i) = B300(1);
    boy300(i) = B300(2);
    boz300(i) = B300(3);
    time300(i) = i;
end
%500km
%{
for i = 1:T_s500*15
    lon = lon0*i;
    lat500 = lat500_0*i;
    B500 = igrf(datenum(2020,12,27,12,0,i),lat500,lon,alt500*10^-3)*10^-9;
    box500(i) = B500(1);
    boy500(i) = B500(2);
    boz500(i) = B500(3);
    time500(i) = i;
end
%800km
for i = 1:T_s800*15
    lon = lon0*i;
    lat800 = lat800_0*i;
    B800 = igrf(datenum(2020,12,27,12,0,i),lat800,lon,alt800*10^-3)*10^-9;
    box800(i) = B800(1);
    boy800(i) = B800(2);
    boz800(i) = B800(3);
    time800(i) = i;
end
%}
savefile = 'igrf11-300km.mat';
save(savefile, 'time300', 'box300', 'boy300', 'boz300');
%savefile = 'igrf11-500km.mat';
%save(savefile, 'time500', 'box500', 'boy500', 'boz500');
%savefile = 'igrf11-800km.mat';
%save(savefile, 'time800', 'box800', 'boy800', 'boz800');
figure(1)
hold on
grid
legend('x(T)','y(T)','z(T)')
plot(box300,'b')
plot(boy300,'g')
plot(boz300,'r')
%{
figure(2)
hold on
grid
legend('x(T)','y(T)','z(T)')
plot(box500,'b')
plot(boy500,'g')
plot(boz500,'r')
figure(3)
hold on
grid
legend('x(T)','y(T)','z(T)')
plot(box800,'b')
plot(boy800,'g')
plot(boz800,'r')
%}