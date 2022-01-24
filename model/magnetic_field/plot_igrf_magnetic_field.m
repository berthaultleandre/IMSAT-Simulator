function [] = plot_magnetic_field()
load igrf11-300km.mat
plot(box300)
hold on
plot(boy300)
hold on
plot(boz300)
end

