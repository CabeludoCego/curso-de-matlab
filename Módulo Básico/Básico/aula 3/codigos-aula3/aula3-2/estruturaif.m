clc
clear
disp('ax^2 + bx + c = 0')
a =  input('Digite o coeficiente A: ');
b = input('Digite o coeficiente B: ');
c = input('Digite o coeficiente C: ');
delta = b^2 - 4*a*c;
if (delta < 0)
    disp('A equa��o possui duas ra�zes complexas distintas!');
    disp('Valor de delta obtido: ');
    disp(delta);
elseif (delta > 0)
    disp('A equa��o possui duas ra�zes reais distintas!')
    disp('Valor de delta obtido: ');
    disp(delta);
else
    disp('A equa��o possui apenas uma ra�z!');
    disp('Valor de delta obtido: ');
    disp(delta);
end