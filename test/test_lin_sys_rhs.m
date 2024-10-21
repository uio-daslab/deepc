clear all; close all; clc;

% author: Mathias Hudoba de Badyn
% last edit: 21.10.2024
% purpose: unit test for lin_sys_rhs

% test that the input sanitization is correct

    %TEST: interpolate the input at a point beyond the range of t_space
    %EXPECT: error caught by catch
    params.A = rand(2,2);
    params.B = rand(2,2);
    params.u = [1,1;1,1];
    params.t_space = [1,2];
    x = [1;1];
    input_flag = 1;
    try
        x_dot = lin_sys_rhs(3, x, params);
    catch ME
        switch ME.identifier
            case 'lin_sys_rhs:interp_out_of_bounds'
                input_flag = 1;
        end
    end
    assert(input_flag==1)

% test that the derivative is correct

    %TEST: use known data to compute derivative
    %EXPECT: assertion succeeds

    params.A = rand(2,2);
    params.B = rand(2,2);
    params.u = [1,1;1,1];
    params.t_space = [1,2];
    x = [1;1];
    x_dot_true = params.A*x + params.B*params.u(:,1);

    x_dot = lin_sys_rhs(1, x, params);
    assert(norm(x_dot - x_dot_true)<1E-9)

