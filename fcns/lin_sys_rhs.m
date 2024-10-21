% author: Mathias Hudoba de Badyn
% last edit: 21.10.2024
% purpose: function for simulating a linear system with input described in
% a vector params.u over a timespan params.t_space

function [x_dot] = lin_sys_rhs(t, x, params)
%lin_sys_rhs: outputs the right-hand-side of a linear system ODE subject to
%an input signal u

%%INPUTS
% t: time
% x: state variable
% params: struct that includes:
%         A: state matrix
%         B: control matrix
%         u: array of control inputs (columns correspond to time)
%         t_space: vector of times
%%OUTPUTS
% x_dot: derivative of the state variable; right-hand-side of linear system

% input sanitization

if t<min(params.t_space) || t>max(params.t_space)
    error_input.message = 'The control is being interpolated at time outside array.';
    error_input.identifier = 'lin_sys_rhs:interp_out_of_bounds';
    error(error_input)
end

% interpolate input to time t
[n,m] = size(params.B);
u_in = zeros(m,1);

for ii = 1:m
    u_in(ii) = interp1(params.t_space, params.u(ii,:), t);
end

% output derivative
x_dot = params.A*x + params.B*u_in;

end