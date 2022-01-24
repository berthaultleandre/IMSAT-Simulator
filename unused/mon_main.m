clear all
close all
clc
%cd 'C:\Users\djoff\OneDrive\Documents\IMT\A3\projet 3A\courbes'

line2 = '2 25544  51.6454 114.3468 0000873 353.4400   1.0119 15.49140402239344';
%  n° catalogue   inclinaison(°) noeud_ascendant(°) excentricité
%  arg_périgé(°) anomalie_moyenne(°) n_rev/jour


global mu J2 Re S Cd rho erad prad T w0

mu = 3.986004418e14; %si
J2 = 1.0827e-3;
Re = 6371e3; %m
S=0.01; %m2
Cd=2.2;
rho=2.6*10^(-12); %kg/m3
erad = 6378.1e3;  % equatorial radius (m)
prad = 6356.8e3;  % polar radius (m)

nb_per=5;

[a, incl, Omega, e, w, M, n] = TLE_to_orbital_elements(line2);
[E, f] = get_Ef(M, e);
[r, v] = orbital_elements_to_ECI(a ,e, incl, Omega, w, f);
draw_earth_non_spherical();
%tspan = [0 86164];
y0 = [r,v];
tol = 1e-10;


w0=sqrt(mu/norm(r)^3);
T=2*pi/w0;
tspan = [0 nb_per*T];
%ECI frame

%% basic
[t1, r_eci_1,v_eci_1] = plot_orbit(tspan, y0, tol, false);

%% Only J2
[t2, r_eci_2,v_eci_2] = plot_orbit(tspan, y0, tol, true);

%% J2+ drag

[t3, r_eci_3, v_eci_3] = plot_J2drag(tspan,y0, tol);

r1=[];r2=[];r3=[];
rm1=[];rm2=[];rm3=[];
vm1=[];vm2=[];vm3=[];
v1=[];v2=[];v3=[];
tm1=[0];tm2=[0];tm3=[0];
i1=1;i2=1;i3=1;
k=2;
for i=1:size(t1)
    r1(i)=norm(r_eci_1(:,i));
    v1(i)=norm(v_eci_1(:,i));
    if t1(i)-tm1(k-1)>=T
        rm1(k)=mean(r1(i1:i));
        vm1(k)=mean(v1(i1:i));
        i1=i;
        tm1(k)=tm1(k-1)+T;
        k=k+1;
    end      
end

rm1(1)=[];
vm1(1)=[];
tm1(1)=[];
k=2;

for i=1:size(t2)
    r2(i)=norm(r_eci_2(:,i));
    v2(i)=norm(v_eci_2(:,i));
    if t2(i)-tm2(k-1)>=T
        rm2(k)=mean(r2(i2:i));
        vm2(k)=mean(v2(i2:i));
        i2=i;
        tm2(k)=tm2(k-1)+T;
        k=k+1;
    end      
end

rm2(1)=[];
vm2(1)=[];
tm2(1)=[];
k=2;

for i=1:size(t3)
    r3(i)=norm(r_eci_3(:,i));
    v3(i)=norm(v_eci_3(:,i));
    if t3(i)-tm3(k-1)>=T
        rm3(k)=mean(r3(i3:i));
        vm3(k)=mean(v3(i3:i));
        i3=i;
        tm3(k)=tm3(k-1)+T;
        k=k+1;
    end      
end

rm3(1)=[];
vm3(1)=[];
tm3(1)=[];

figure;
plot(t1,r1)
hold on
plot(t2,r2)
hold on
plot(t3,r3)
legend("basic","J2", "J2+drag",'Location','west')
title('Distance of the ISS around Earth using ODE45')
xlabel('t (s)')
ylabel('r (m)')
  %saveas(gcf, 'distance', 'png');    

figure;
plot(tm1,rm1), hold on
plot(tm2,rm2), hold on
plot(tm3,rm3)
legend("basic","J2", "J2+drag",'Location','west')
title('Mean distance of the ISS around Earth using ODE45')
%saveas(gcf, 'mean_distance', 'png');    

figure;
plot(tm1,vm1), hold on
plot(tm2,vm2), hold on
plot(tm3,vm3)
legend("basic","J2", "J2+drag",'Location','west')
title('Mean speed of the ISS around Earth using ODE45')
%saveas(gcf, 'mean_speed', 'png');    

figure;
plot(t1,v1)
hold on
plot(t2,v2)
hold on
plot(t3,v3)
legend("basic","J2", "J2+drag",'Location','west')
title('Speed of the ISS around Earth using ODE45')
xlabel('t (s)')
ylabel('v (m/s)')
%saveas(gcf, 'speed', 'png');    
%figure(3); %ECEF frame
%omega_e = 2*pi/86164;