clear
clc
format long

syms x1 x2 x3 alfa
f(x1, x2, x3) = 19 * x1^2 - 2 * x1 * x2 + x2^2 - x3 - x2 * x3 + 8 * x3^2;

eps = 0.01;
x0 = [1; 0; 0];

a = x0(1);
b = x0(2);
c = x0(3);

g(x1, x2, x3) = gradient(f);
B0 = eye(3);
i = 0;

g1 = g(a, b, c);
norm = sqrt(g1(1)^2 + g1(2)^2 + g1(3)^2);
norm = double(norm);

disp(['x' num2str(i) ' = [' num2str(a, '%4.3f') ',' num2str(b, '%4.3f') ',' num2str(c, '%4.3f') ']; ||grad f(x' num2str(i) ')|| =' num2str(norm, '%4.6f') ])

xp = x0;
B = B0;


while eps < norm

      dp = - B * g(a,b,c);
      xn = xp + alfa * dp;
      
      %szukanie optymalnego kroku
      f_krok = f(xn(1), xn(2), xn(3));
      eqn = gradient(f_krok) == 0;
      alfa_star = solve(eqn, alfa);
      
      %nowe przyblizenie
      xn = xp + alfa_star * dp;
      xn = double(xn);
     
      a = xn(1);
      b = xn(2);
      c = xn(3);
      
      g0 = g1;
      g1 = g(a, b, c);
      q = g1 - g0;
      norm = sqrt(g1(1)^2 + g1(2)^2 + g1(3)^2);
      norm = double(norm);
      i = i + 1;
      
      disp(['x' num2str(i) ' = [' num2str(a, '%4.3f') ',' num2str(b, '%4.3f') ',' num2str(c, '%4.3f') ']; ||grad f(x' num2str(i) ')|| =' num2str(norm, '%4.6f') ])
      
      D = dp' * q;
      A = dp * dp' / D;
      C = q' * B * q / D;
      E = (B* q * dp' + dp *q' * B) / D;
      
      dB = A*(1 + C) - E;
      B = B + dB;
      xp = xn;
end