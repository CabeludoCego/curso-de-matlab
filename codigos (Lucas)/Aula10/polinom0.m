% M�todos para usar Polin�mios

%% Poly e relacionados

% Para o polin�mio y = x^2 - 6*x + 9 = (x-3)*(x-3)
% Extra�mos seus coeficientes:
% p = [1 -6 9];
% % E obtemos as ra�zes com roots:
% x12 = roots(p) 
% % E para o caso contr�rio
% Temos as ra�zes x1 = x2 = 3
% r = [3 3];
% % E podemos obter os coeficientes do polin�mio
% y = poly(r)

%% Fun��o An�nima

% f =@(x) => Temos uma vari�vel f que recebe a resposta
% de uma fun��o que requer o par�metro x.

% % f =@(x) ((x)^2 + 2);
% f =@(x) (x)^2 - 6*x + 9;
% % f(3)      % f1(x=3) = 9 + 2 = 11
            % f2(x=3) = 9 - 18 + 9 = 0

%% Vari�vel simb�lica (syms)
% 
syms x
% k = (x+2)*(x+2);  % Exemplo de aplica��o: Achar coeficientes
% % k(2)  % Erro
% 
% m(x) = (x+2)*(x+2);  % x^2 + 4x + 4
% m(2)

% Logo, o ideal pode ser multiplicar v�rios polin�mios
% usando syms e depois definir um valor num�rico para a vari�vel.

% Aplica��o: encontrar coeficientes.
n = (x+3)^3;
k = (x+2)*(x+2);
g = k*n;
coeffs(g)  % Da ordem zero at� a maior ordem



