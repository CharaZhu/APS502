 
%Q: Symmetric matrix represents the quadratic term in objective
Q = [0.00113327, -0.00012307, 0.00068210; 
    -0.00012307, 0.00009850, -0.00002484; 
    0.00068210, -0.00002484, 0.00106246;];
%c: Coefficient vector for the linear term in objective
c = [0 0 0]';
%A, b: Inequality constraints (<)
A = -[0.00738002, 0.00300033, 0.00100985];

%Aeq, beq: Equality constraints
Aeq = [1 1 1]; 
beq = [1];

%lb, ub: Variable bounds
ub = [inf; inf; inf;];
% lb without constrain (allow short selling)
lb_1 = [-inf; -inf; -inf;]; 
% lb with constrain (not allow short selling)
lb_2 = [0; 0; 0;]; 
  
 
R = linspace(0.00100985,0.00738002,10); %expected return goal
var_1 = []; %variance of protfolio with short selling 
var_2 = []; %variance of protfolio without short selling 
vol_1 = []; %volatility of protfolio with short selling 
vol_2= [];  %volatility of protfolio without short selling 
weight_1 = []; %portfolio weight with short selling 
weight_2 = []; %portfolio weight without short selling

for i=1:10  
    b = -R(i);
    %without constrain (allow short selling)
    [x_1, fval_1, exitflag_1, output_1, lambda_1] = quadprog(Q, c, A, b, Aeq, beq, lb_1, ub);
    weight_1= [weight_1;x_1'];
    var_1 = [var_1;(fval_1*2)];
    vol_1 = [vol_1;sqrt(fval_1*2)];
    
    % lb with constrain (not allow short selling)
    [x_2, fval_2, exitflag_2, output_2, lambda_2] = quadprog(Q, c, A, b, Aeq, beq, lb_2, ub);
    weight_2= [weight_2;x_2'];
    var_2 = [var_2;(fval_2*2)];
    vol_2 = [vol_2;sqrt(fval_2*2)];
end

% plot efficient frontier and points correspond to R
plot(vol_1(4:10),R(4:10),'r-o',vol_2(4:10),R(4:10),'b-o',vol_1,R,'o',vol_2,R,'o')
legend('EF with short selling','EF without short selling') 
ylim([0,0.00738002]) 
ylabel('expected return goal R')
xlabel('volatility')
title('The efficient frontier of MVO')

format long
fprintf('portfolio allow short selling:\n')
fprintf('portfolio weight:\n')
weight_1
fprintf('portfolio variance:\n')
var_1

fprintf('portfolio not allow short selling:\n')
fprintf('portfolio weight:\n')
weight_2
fprintf('portfolio variance:\n')
var_2





 


