% problem 1

f = [-0.04,-0.03,0];
A = [1,1,1; 
     2/100000,1/100000, 0; 
     3/100000, 4/100000, 0];
b = [100000; 1.5; 3.6];
Aeq = [];
beq = [];
lb = [0;0;0];
%ub = [100000,100000];

% call linprog to compute optimal values
[x,fval] =  linprog(f,A,b,Aeq,beq,lb)
 