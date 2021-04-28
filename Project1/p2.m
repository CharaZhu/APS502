% problem 2, part 1

f = [108, 94, 99, 92.7, 96.6, 95.9, 92.9, 110, 104, 101, 107, 102, 95.2, 0, 0, 0, 0, 0];
A = [-10, -7, -8, -6, -7, -6, -5, -10, -8, -6, -10, -7, -100,  1, 0, 0, 0, 0; 
     -10, -7, -8, -6, -7, -6, -5, -10, -8, -6, -110, -107, 0, -1, 1, 0, 0, 0;
     -10, -7, -8, -6, -7, -6, -5, -110, -108, -106, 0, 0, 0,   0, -1, 1, 0, 0;
     -10, -7, -8, -6, -7, -106, -105, 0, 0, 0, 0, 0, 0,        0, 0, -1, 1, 0;
     -10, -7, -8, -106, -107, 0, 0, 0, 0, 0, 0, 0, 0,          0, 0, 0, -1, 1;
     -110, -107, -108, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,           0, 0, 0, 0, -1
     ];
b = [-500; -200; -800; -400; -700; -900];
Aeq = [];
beq = [];
lb = [0; 0; 0; 0; 0; 0; 0; 0; 0; 0; 0; 0; 0; 
      0; 0; 0; 0; 0];

% call linprog to compute optimal values
[x,fval] =  linprog(f,A,b,Aeq,beq,lb)
