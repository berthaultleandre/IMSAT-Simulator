global all_wheels_configs

all_wheels_configs=containers.Map;

W_orthogonal=eye(3);
new_wheels_config('Orthogonal',W_orthogonal);

W_thetrahedral=[sqrt(1/3) sqrt(1/3) -sqrt(1/3) -sqrt(1/3);
    sqrt(2/3) -sqrt(2/3) 0 0;
    0 0 -sqrt(2/3) sqrt(2/3)];
new_wheels_config('Thetrahedral',W_thetrahedral);