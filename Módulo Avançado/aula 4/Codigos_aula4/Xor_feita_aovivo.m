%% C�digo da porta XOR comentado: Aplica��o de MLP

% A inten��o do c�digo a seguir, feito ao vivo durante a aula 
% do Curso de Matlab: M�dulo avan�ado, � de mostrar passo a passo
% a constru��o do c�digo e como deve ser a estrutura de uma MLP.

%% Se��o 1: Declara��es do problema (Atualiza��o Local)

clear;          % Apaga vari�veis da mem�ria
close all;      % Fecha imagens e janelas abertas pelo Matlab
clc;            % Limpa a Command Window

% Entradas e Sa�das 

X = [0 1 0 1
     0 0 1 1];       % 2 linhas de Entradas, 4 pares ao todo.
Pares = size(X,2);
X = [ones(1,4); X];  % Adi��o do Bias = 3x4
     
D = [0 1 1 0];       % Sa�da desejada

% Par�metros da Rede

a = 0.4;                  % Taxa de aprendizado
epomax = 5000;            % N�mero de �pocas    
ev = ones(epomax, Pares); % Vetor de erros
% MSE = ones(epomax,1);     % Vetor do MSE
MSE = [1]; 

% Fun��o de Ativa��o
F =@(x) 1./(1+exp(-(x))); % Log�stica Sigmoide 
f =@(x) F(x).*(1-F(x));

% Pesos da Rede Neural

variaveis = 2;                     % N�mero de vari�veis do problema
respostas = 1;                     % Vari�veis para expressar a resposta
neu = 2;                           % neu >= respostas

% Importante: 
% o vars+1 e neu+1 se referem ao bias. Caso n�o us�-lo,remova o 1.

W = 2*rand(variaveis+1,neu)-1; % 2 pesos + bias
M = 2*rand(neu+1,respostas)-1;

Wt = W; Mt = M;   
epc = 1; 

%% Se��o 2: Loop de Treinamento Local
% Ta fazendo infinitamente.

% Ajustar pra fazer at� o erro zerar, s� descomentar.
% while(epc < epomax && (abs(MSE(epc)) > 0.005))

% Loop comum sem erro no meio.
while(epc < epomax)  

    for i=1:Pares
        xi = X(:,i); % 3x1 
        di = D(i);   % 1x1
        
        u1 = Wt'*xi; % = 2x3 * 3x1 = 2x1
        Y1 = F(u1); % Fun��o sigmoide
    
        x2 = [1; Y1]; %  3x1
        u2 = Mt'*x2; % = 1x3 * 3x1
        Y2 = F(u2);  %   1x1
    
        e = di - Y2; % e = 1x1
        ev(epc+1,i) = e;
        
        delta_2 = e.*f(u2);   % 1x1
        MDelta = Mt(2:end,:); % 2x1 
        delta_1 = (MDelta*delta_2').*f(u1); % (2x1 * 1x1) .* (2x1)
    
        Wt = Wt + a*(xi*delta_1');  % 3x2 = 3x1 * 1x2
        Mt = Mt + a*(x2*delta_2'); % 3x1 = 3x1 * 1x1
        
    end
    
    % C�lculo do MSE : Mean Square Error
%     MSE(epc) = (sum((ev(epc,:).^2))/(Pares*2));
    epc = epc + 1;
    MSE(epc) = (sum((ev(epc,:).^2))/(Pares*2));
    
end

%% Se��o 3: Mostra dos resultados da Rede

% Parte do plot dos pontos e retas
figure(1)
P1 = X(2, [1 4]); P2 = X(3, [1 4]); % Plota os pontos 0
plot(P1, P2, '.red', 'Markersize', 20);
hold on;
P3 = X(2, [2 3]); P4 = X(3, [2 3]);  % Plota os pontos 1
plot(P3, P4, '.blue', 'Markersize', 20);
hold on;
grid on;
axis([-2 2 -2 2]);
title('Final do processo iterativo'); hold on;

% Plot da Reta 1
x1 = linspace(-2,2,30);
x2 = -((Wt(2,1)*x1 + Wt(1,1))/Wt(3,1));
plot(x1, x2);
hold on

% Plot da reta 2
y1 = linspace(-2,2,30);
y2 = -((Wt(2,2)*y1 + Wt(1,2))/Wt(3,2));
plot(y1, y2);
hold on

% Gr�fico do MSE x �pocas

% O novo gr�fico serve para os dois whiles citados,
% com Condi��o de Erro e Sem. 

epc_plot = 1:1:(epc-1); % Extra que fiz pq o elemento 1 de epomax fica 1.
MSE_plot = MSE(2:end);

figure (2)
plot(epc_plot,MSE_plot)
title('�pocas x Erro M�dio Quadr�tico');
xlabel('�pocas');
ylabel('MSE');
