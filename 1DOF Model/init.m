%% Project [Name]: 1-DOF Hydrofoil Initialization Script
% Run this script before starting the Simulink model.

clear; clc;

%% 1. Environmental Constants
rho = 1025;         % Density of seawater (kg/m^3)
g = 9.81;           % Gravity (m/s^2)

%% 2. Physical Properties (The "Body")
m = 585;            % Total mass (kg) - Boat + Pilot + Battery
weight = m * g;     % Static weight (N)

%% 3. Hydrodynamic Properties (The "Foils")
data = readmatrix("NACA 0009.txt", "NumHeaderLines", 11);
alpha_deg = data(:, 1); 
cl_data = data(:, 2);
cd_data = data(:, 3);

V_takeoff = 16.6667; % Target velocity (m/s) ~50kph
S_total = 0.3;     % Total surface area of all foils (m^2)
CL_alpha = 2 * pi;  % Lift slope (theoretical, per radian)
D_heave = 500;      % Damping coefficient (Newton-seconds per metre)

% Pre-calculate the dynamic pressure constant
% Force = q * S * C_L
q_S = 0.5 * rho * V_takeoff^2 * S_total;

%% 4. Actuator Properties (The "Mateo" Constraints)
% Based on typical 0.15s/60deg servo specs
servo_speed_deg_sec = 400; 
servo_max_speed = deg2rad(servo_speed_deg_sec); % (rad/s) for Rate Limiter

%% 5. Sensor Properties
height_sensor_freq = 10; % Hz (Ultrasonic)
sensor_sample_time = 1 / height_sensor_freq; % 0.1s for Zero-Order Hold

%% 6. Initial Conditions
start_height = 0.1; % Boat starts 10cm deep in water
target_height = 0.5; % Target flight height (m)

disp('Project [Name] initialized. Ready for simulation.');