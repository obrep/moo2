clear all
clc
format long

g_acc=9.81;
m1=1;
m2=1;
l=1;
F=0;

syms x y 
f(x,y)=-g_acc*l*(m1*cos(x)+2*m2*cos(x)+m2*cos(y)) - 2*F*l*(sin(x)+sin(y));

eps=10e-8;
x0=[pi/6;pi/3];

a=x0(1);
b=x0(2);
i=0;

g(x,y)=gradient(f);
h(x,y)=hessian(f);

g1=g(a,b);
norm=sqrt(g1(1).^2+g1(2).^2);
norm=double(norm);

disp(['x' num2str(i) ' = [' num2str(a, '%4.3f') ',' num2str(b, '%4.3f') ']; ||grad f(x' num2str(i) ')|| =' num2str(norm, '%4.3f') ])

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
      
      disp(['x' num2str(i) ' = [' num2str(a, '%4.3f') ',' num2str(b, '%4.3f') ']; ||grad f(x' num2str(i) ')|| =' num2str(norm, '%4.3f') ])
      xp=xn;
end

x1=l*sin(xp(1));
y1=-l*cos(xp(1));
phi1=270+xp(1)*180/pi;

x2=2*l*sin(xp(1))+l*sin(xp(2));
y2=-2*l*cos(xp(1))-l*cos(xp(2));
phi2=270+xp(2)*180/pi;

 disp(['q1 = [x1, y1, phi1] = [' num2str(x1, '%4.3f') ', ' num2str(y1, '%4.3f') ', '  num2str(phi1, '%4.3f') ']' ])
 disp(['q2 = [x2, y2, phi2] = [' num2str(x2, '%4.3f') ', ' num2str(y2, '%4.3f') ', '  num2str(phi2, '%4.3f') ']' ])