%% Gr�fico de linha
t = 0:0.01:10;
x = exp(-2*t).*cos(2*t);
y = exp(-2*t).*sin(2*t);
plot3(x,y,t,'g--')
xlabel('x');
ylabel('y');
zlabel('z');
%% Gr�fico de malha,superf�cie e contour
[x,y] = meshgrid(-10:0.1:10,-10:0.1:10);
z = exp(-0.5*(x.^2+y.^2));
contour(x,y,z)