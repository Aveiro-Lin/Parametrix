clear; clc;

% Define constant
rho = 8960; % Density, kg/m^3
cv = 385; % Specific heat capacity, J/(kg*K)
dx = 0.0001; % Spatial step size
dt = 0.0001; % Temporal step size
c1 = 0.1467; % Coefficient
h=7;%w/m^2*k
% k=237;%Coefficient of thermal conductivity 237w/m*k
A = 1; % The cross-sectional area is 1
dheat =0;
% Initialization temperature and heat
T = 25 * ones(11, 1);
Tp = 25 * ones(11, 1);

h=7;%heat convection
Heat_in = 0;
Heat_out = 0;
m=rho*cv*dx*dx/dt;
n=h*dx;

% Define the number of iterations
num_iterations = 2;
max_inner_iterations = 100;
tolerance = 1e-9;

        K1_5 = 404.6675-((T(1) + T(2)) / 2) * c1;
        K2_5 = 404.6675-((T(2) + T(3)) / 2) * c1;
        K3_5 = 404.6675-((T(3) + T(4)) / 2) * c1;
        K4_5 = 404.6675-((T(4) + T(5)) / 2) * c1;
        K5_5 = 404.6675-((T(5) + T(6)) / 2) * c1;
        K6_5 = 404.6675-((T(6) + T(7)) / 2) * c1;
        K7_5 = 404.6675-((T(7) + T(8)) / 2) * c1;
        K8_5 = 404.6675-((T(8) + T(9)) / 2) * c1;
        K9_5 = 404.6675-((T(9) + T(10)) / 2) * c1;
        K10_5 = 404.6675-((T(9) + T(10)) / 2) * c1;
        
        M1=abs(T(1)+25*2);
        M2=(abs(-K1_5*T(1)) + abs((m + K1_5 + K2_5)*T(2)) + abs(-K2_5*T(3)) + abs(m*Tp(2)))*2;
        M3=(abs(-K2_5*T(2)) + abs((m + K2_5 + K3_5)*T(3)) + abs(-K3_5*T(4)) + abs(m*Tp(3)))*2;
        M4=(abs(-K3_5*T(3)) + abs((m + K3_5 + K4_5)*T(4)) + abs(-K4_5*T(5)) + abs(m*Tp(4)))*2;
        M5=(abs(-K4_5*T(4)) + abs((m + K4_5 + K5_5)*T(5)) + abs(-K5_5*T(6)) + abs(m*Tp(5)))*2;
        M6=(abs(-K5_5*T(5)) + abs((m + K5_5 + K6_5)*T(6)) + abs(-K6_5*T(7)) + abs(m*Tp(6)+38400))*2;
        M7=(abs(-K6_5*T(6)) + abs((m + K6_5 + K7_5)*T(7)) + abs(-K7_5*T(8)) + abs(m*Tp(7)))*2;
        M8=(abs(-K7_5*T(7)) + abs((m + K7_5 + K8_5)*T(8)) + abs(-K8_5*T(9)) + abs(m*Tp(8)))*2;
        M9=(abs(-K8_5*T(8)) + abs((m + K8_5 + K9_5)*T(9)) + abs(-K9_5*T(10)) + abs(m*Tp(9)))*2;
        M10=(abs(-K9_5*T(9)) + abs((m + K9_5 + K10_5)*T(10)) + abs(-K10_5*T(11)) + abs(m*Tp(10)))*2;
        M11=(abs(-2*K10_5*T(10)) + abs((m + 2*K10_5+2*n)*T(11)) + abs(m*Tp(11)+50*n))*2;
        M1 = 0; M2 = 0; M3 = 0; M4 = 0; M5 = 0; M6 = 0; M7 = 0; M8 = 0;M9 = 0; M10 = 0; M11 = 0; 
for t = 1:num_iterations
    % Internal loop: Newton-Raphson iteration
    for inner_iter = 1:max_inner_iterations


        % Construct the Jacobian matrix a
        a = [1+M1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0;
             -K1_5, m + K1_5 + K2_5 + M2, -K2_5, 0, 0, 0, 0, 0, 0, 0, 0;
             0, -K2_5, m + K2_5 + K3_5 + M3, -K3_5, 0, 0, 0, 0, 0, 0, 0;
             0, 0, -K3_5, m + K3_5 + K4_5 + M4, -K4_5, 0, 0, 0, 0, 0, 0;
             0, 0, 0, -K4_5, m + K4_5 + K5_5 + M5, -K5_5, 0, 0, 0, 0, 0;
             0, 0, 0, 0, -K5_5, m + K5_5 + K6_5 + M6, -K6_5, 0, 0, 0, 0;
             0, 0, 0, 0, 0, -K6_5, m + K6_5 + K7_5 + M7, -K7_5, 0, 0, 0;
             0, 0, 0, 0, 0, 0, -K7_5, m + K7_5 + K8_5 + M8, -K8_5, 0, 0;
             0, 0, 0, 0, 0, 0, 0, -K8_5, m + K8_5 + K9_5 + M9, -K9_5, 0;
             0, 0, 0, 0, 0, 0, 0, 0, -K9_5, m + K9_5 + K10_5 + M10, -K10_5;
             0, 0, 0, 0, 0, 0, 0, 0, 0, -2*K10_5, m + 2*K10_5+2*n + M11; ];

        % B-matrix construction
        b = [25;
             m*Tp(2);
             m*Tp(3);
             m*Tp(4);
             m*Tp(5);
             m*Tp(6)+38400;
             m*Tp(7);
             m*Tp(8);
             m*Tp(9);
             m*Tp(10);
             m*Tp(11)+50*n;
             ];

        % Use Newton-Raphson method to solve
        T_new = a \ b;
        
        % if inner_iter < 21
        %     M1 = M1/10; M2 = M2/10; M3 = M3/10;  M4 = M4/10; M5 = M5/10; M6 = M6/10;  M7 = M7/10; M8 = M8/10; M9 = M9/10; M10 = M10/10; M11 = M11/10;
        % 
        % elseif inner_iter == 11
        %     M1 = 1; M2 = 1; M3 = 1; M4 = 1; M5 = 1; M6 = 1; M7 = 1; M8 = 1; M9 = 1; M10 = 1; M11 = 1; 
        % 
        % elseif inner_iter >11 && inner_iter <22
        %     M1 = M1-0.1; M2 = M2-0.1; M3 = M3-0.1; M4 = M4-0.1;  M5 = M5-0.1; M6 = M6-0.1; M7 = M7-0.1; M8 = M8-0.1;  M9 = M9-0.1; M10 = M10-0.1; M11 = M11-0.1; 
        % 
        % elseif  inner_iter >21
        %     M1 = 0; M2 = 0; M3 = 0; M4 = 0; M5 = 0; M6 = 0; M7 = 0; M8 = 0;M9 = 0; M10 = 0; M11 = 0; 
        % end
        % Check for convergence
        if norm(T_new - T, inf) < tolerance
            break;
        end

        % Update T to the newly solved temperature
        T = T_new;
    end
    

    % Calculated heat
    Heat_in =  Heat_in+38400+K1_5*(T(1) - T(2))/dx*A*dt;
    Heat_out = Heat_out+h*(T(11)-25)*A*dt;

    % Update Tp to the current time temperature
    Tp = T;
end

% Calculated internal energy increase
dheat = Heat_in - Heat_out;
internal_energy_increase = (cv * ( T(2) + T(3) + T(4) + T(5) + T(6) + T(7) + T(8) + T(9) + T(10)- 25*9)) * A * dx * rho+ (cv * (T(11)- 25)) * A * dx / 2 * rho;

% Plot result
x = linspace(1, 11, 11);
plot(x, T, 'linewidth', 1.5);
grid on;
xlabel('Position');
ylabel('Temperature (°C)');
title('Temperature Distribution');

% Output result
fprintf('Heat in: %.4f J\n', Heat_in);
fprintf('Heat out: %.4f J\n', Heat_out);
fprintf('Change in heat: %.4f J\n', dheat);
fprintf('Internal energy increase: %.4f J\n', internal_energy_increase);
