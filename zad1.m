clear 
clc
format long

%dane
syms x1 x2
r1(x1, x2) = x1^2 + 8 * x2^2 + 2 * x1 - 655;
r2(x1, x2) = 16 * x1 * x2 + 6 * x2 - 1456;
eps = 0.1;
x0 = [11.3; 7.8];

a = x0(1);
b = x0(2);
i = 0;

f(x1, x2) = 0.5 * (r1 * r1 + r2 * r2);
g(x1, x2) = gradient(f);
h(x1, x2) = hessian(f);

g1 = g(a, b);
norm = sqrt(g1(1)^2 + g1(2)^2);
norm = double(norm);

disp(['x' num2str(i) ' = [' num2str(a) ',' num2str(b) ']; ||grad f(x' num2str(i) ')|| =' num2str(norm) ])

xp = x0;

while eps < norm
      dp = - inv(h(a, b)) * g(a, b);
      xn = xp + dp;
      xn = double(xn);
     
      a = xn(1);
      b = xn(2);
      g1 = g(a, b);
      norm = sqrt(g1(1)^2 + g1(2)^2);
      norm = double(norm);
      i = i+1;
      %wyswietl wyniki
      disp(['x' num2str(i) ' = [' num2str(a) ',' num2str(b) ']; ||grad f(x' num2str(i) ')|| =' num2str(norm) ])
      xp = xn;
end