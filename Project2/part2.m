 
%Q: Symmetric matrix represents the quadratic term in objective
Q = [0.00113327, -0.00012307, 0.00068210, 0.00024939,	  0.00094254,	0.00026041,	0.00058589,	0.00122228;
    -0.00012307, 0.00009850,  -0.00002484,	-0.00006244,  0.00003185,	0.00002323,	-0.00010802,-0.00008293;
     0.00068210, -0.00002484, 0.00106246,	-0.00020499,  0.00065582,	-0.00008895,-0.00000082,0.00057814;
     0.00024939, -0.00006244, -0.00020499,	0.00199533,	  0.00088056,	0.00114209,	0.00112676,	0.00037369;
     0.00094254, 0.00003185,  0.00065582,	0.00088056,	  0.00288922,	0.00052664,	0.00070973,	0.00135153;
     0.00026041, 0.00002323,  -0.00008895,	0.00114209,	  0.00052664,	0.00331965,	0.00088286,	0.00044015;
     0.00058589, -0.00010802, -0.00000082, 	0.00112676,	  0.00070973,	0.00088286,	0.00223497,	0.00094864;
     0.00122228, -0.00008293, 0.00057814,	0.00037369,	  0.00135153,	0.00044015,	0.00094864,	0.00231737;];

%c: Coefficient vector for the linear term in objective
c = [0 0 0 0 0 0 0 0]';
%A, b: Inequality constraints (<)
A = -[0.00738002,0.00300033,0.00100985,0.01401204,0.01411464,0.01057789,0.01048744,0.01283322];

%Aeq, beq: Equality constraints
Aeq = [1 1 1 1 1 1 1 1]; 
beq = [1];

%lb, ub: Variable bounds
ub = [inf; inf; inf;];
% lb without constrain (allow short selling)
lb_1 = [-inf; -inf; -inf;]; 
% lb with constrain (not allow short selling)
lb_2 = [0; 0; 0;]; 
  
 
R = linspace(0.00100985,0.01411464,10); %expected return goal
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

% plot efficient frontier  
plot(vol_1(2:10),R(2:10),'r-o',vol_2(2:10),R(2:10),'b-o',vol_1,R,'o',vol_2,R,'o')
legend('EF with short selling','EF without short selling') 
ylim([0,0.01411464]) 
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

 
