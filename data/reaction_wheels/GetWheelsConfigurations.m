function wheels_configurations = GetWheelsConfigurations()
    wheels_configurations=containers.Map;

    W_orthogonal=eye(3);
    wheels_configurations('Orthogonal')=new_wheels_config('Orthogonal',3,W_orthogonal);

    W_thetrahedral=[sqrt(1/3) sqrt(1/3) -sqrt(1/3) -sqrt(1/3);
        sqrt(2/3) -sqrt(2/3) 0 0;
        0 0 -sqrt(2/3) sqrt(2/3)];
    wheels_configurations('Thetrahedral')=new_wheels_config('Thetrahedral',4,W_thetrahedral);
end