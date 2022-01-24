function [] = draw_earth_non_spherical()
global erad prad
clf;
figure(1)
npanels=20;
axis(2e7*[-1 1 -1 1 -1 1]);
view(9,26);
hold on;
axis vis3d;
[ xx, yy, zz ] = ellipsoid(0, 0, 0, erad, erad, prad, npanels);
globe = surf(xx, yy, -zz, 'FaceColor', 'none', 'EdgeColor', 0.5*[1 1 1]);
end