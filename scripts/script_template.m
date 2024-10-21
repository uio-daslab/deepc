clear all; close all; clc;

% author: Mathias Hudoba de Badyn
% last edit: 21.10.2024
% purpose: template for scripts

%% test script - simulate a linear system with sinusoidal input

% add path for functions and modules
addpath(genpath('../fcns'))

rng(1337)

n = 10;         % number of states
m = 3;          % number of controls
dt = 0.1;       % integration grid

% generate a matrix A that is diagonally dominant
A = rand(n,n);
A = A - diag(diag(A));
params.A = A - diag(A*ones(n,1)+ones(n,1));
params.B = rand(n,m);

params.t_space = 1:dt:10;
params.u = cos(params.t_space);
for ii = 1:m-1
    if mod(ii,2)==0
        params.u = [params.u; sin(params.t_space)];
    else
        params.u = [params.u; cos(params.t_space)];
    end
    
end


% simulate system
x_array = zeros(n,length(params.t_space));
x_array(:,1) = rand(n,1);

[T,Y] = ode45(@lin_sys_rhs,params.t_space,x_array(:,1),[],params);
plot(T,Y')


