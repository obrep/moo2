clear
clc
format long

a = 14.8;
b = 10.6;
c = 15;
d = 17;
syms x1 x2 L1 L2
assume(x1 >= 0)
assume(x2 >= 0)
assume(L1 >= 0)
assume(L2 >= 0)

f(x1, x2) = (x1 - a)^2 + (x2 - b)^2;
c1(x1, x2) = 2 * x1 - x2 - c;
c2(x1, x2) = 0.5 * x1 + x2 - d;

L(x1, x2, L1, L2) = f + L1 * c1 + L2 * c2;
alfa_c(x1, x2, L1, L2) = L1 * c1 + L2 * c2;

dLL = [diff(L, L1); diff(L, L2)];
dLx = [diff(L, x1); diff(L, x2)];

[x1, x2] = solve(dLx, [x1, x2]);

dLL = subs(dLL);
[La, Lb] = solve(dLL, [L1, L2]);

L1 = double(La);
L2 = double(Lb);
x1 = double(subs(x1));
x2 = double(subs(x2));
%w tym miejscu mamy juz L1 L2, i x(L)
%aby alfa*c = 0 musimy miec L1 * c1 == 0 i L2 * c2 == 0
%sprawdzenie

if subs(alfa_c)
   error('Error. \n Warunek alfa * c nie spe³niony')
end

disp(['x = [' num2str(x1, '%4.3f') ',' num2str(x2, '%4.3f') '], L = [' num2str(L1, '%4.3f')  ', ' num2str(L2, '%4.3f') ']'])
      
