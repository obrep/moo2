clear all
clc
format long

syms x y
r1(x,y)=x.^2+y.^2+2.*x-324;
r2(x,y)=2.*x.*y+9.*y-43;

eps=0.1;
x0=[17.3;0.8];

a=x0(1);
b=x0(2);
i=0;

f(x,y)=.5.*(r1.*r1+r2.*r2);
g(x,y)=gradient(f);
h(x,y)=hessian(f);

g1=g(a,b);
norm=sqrt(g1(1).^2+g1(2).^2);
norm=double(norm);

disp(['x' num2str(i) ' = [' num2str(a) ',' num2str(b) ']; ||grad f(x' num2str(i) ')|| =' num2str(norm) ])

xp=x0;

while eps < norm
      dp = - inv(h(a,b))*g(a,b);
      xn = xp + dp;
      xn=double(xn);
     
      a=xn(1);
      b=xn(2);
      g1=g(a,b);
      norm=sqrt(g1(1).^2+g1(2).^2);
      norm=double(norm);
      i=i+1;
      
      disp(['x' num2str(i) ' = [' num2str(a) ',' num2str(b) ']; ||grad f(x' num2str(i) ')|| =' num2str(norm) ])
      xp=xn;
end