function h_sat = wheel_saturation(h_w,h_w_max)
    h_sat=h_w;
    for i=1:length(h_w)
        if (h_sat(i)>h_w_max)
            h_sat(i)=h_w_max;
        end
        if (h_sat(i) < -h_w_max)
            h_sat(i)=-h_w_max;
        end
    end
end
