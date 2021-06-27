%% Se��o 1: Defini��o do Problema

clear;close all;clc;

% Banco da Iris:
% 150 dados, 3 classes, 4 vari�veis para cada indiv�duo.

load iris2.txt
a = iris2';
dados = a(1:end-1,:);
NVaris = size(dados,1);
Nclasses = 3;  

% Normaliza��o dos Dadosco
for i=1:NVaris
   dados(i,:) = dados(i,:)./max(dados(i,:)); 
end

% Adapta��o do vetor resposta desejada.

r = a(5,:);                       % Numera��o das classes: Coluna 5
classes = zeros(Nclasses,size(dados,2)); % Inicializa o vetor de classes zerado.
count = zeros(Nclasses,1);               % Vetor de contagem das classes. 
% Contagem: 50/50/50

for i = 1:size(r,2)   % Preenche o vetor de classes com as posi��es. O Target.
    if r(i) == 1      % Se � Classe 1
        classes(1,i) = 1;
        count(1) = count(1) + 1;
    elseif r(i) == 2  % Se � Classe 2
        classes(2,i) = 1;
        count(2) = count(2) + 1;
    elseif r(i) == 3  % Se � Classe 3
        classes(3,i) = 1;
        count(3) = count(3) + 1;
    end
end

%% Se��o 2: Divis�o dos Dados e similares

% Extra: Randomizar os dados.

% 70% dos dados para Treinamento, 30% para Teste
pTre = 0.7; 
countTre = pTre*count;
countTre = round(countTre); % Arredonda pra baixo

countlow = countTre;
counthig = cumsum(count);
for k=2:Nclasses
   countlow(k) = countlow(1) + counthig(k-1); 
end

dadosTre = dados(1:end, [1:countlow(1), counthig(1)+1:countlow(2), counthig(2)+1:countlow(3)]);
classesTre = classes(1:size(classes,1), [1:countlow(1), counthig(1)+1:countlow(2), counthig(2)+1:countlow(3)]);
    
dadosTes = dados(1:size(dados,1), [countlow(1)+1:counthig(1), countlow(2)+1:counthig(2), countlow(3)+1:counthig(3)]);
classesTes = classes(1:size(classes,1), [countlow(1)+1:counthig(1), countlow(2)+1:counthig(2), countlow(3)+1:counthig(3)]);
% 
% dadosTre = dados(1:end, [1:35, 51:85, 101:135]);
% classesTre = classes(1:Nclasses, [1:35, 51:85, 101:135]);
% 
% dadosTes = dados(1:end, [36:50, 86:100, 136:150]);
% classesTes = classes(1:Nclasses, [36:50, 86:100, 136:150]);

%% Se��o 3: Declara��o de vari�veis pr�-Treinamento

% Vers�o com Bias.

vars = NVaris;     % N�mero de vari�veis do problema = 4
neu = 5;           % N�mero de neur�nios escolhido. neu >= clas. A gosto.
clas = Nclasses;   % N�mero de Classes do problema = 3

W = (2*rand(neu,vars+1)-1); % Pesos ocultos: N neur�nios, vars entradas  
M = (2*rand(clas,neu+1)-1); % Pesos da Sa�da: 3 sa�das, neu + 1 respostas
Wa = W;     Ma = M;

F =@(x) 1./(1+exp(-(x)));   % Log. Sigmoide = F. de inicializa��o
f =@(x) F(x).*(1-F(x));     % Derivada da Sigmoide  

Pares = size(dados,2);         % = 150
TrPares = size(dadosTre,2);  % "Pares" de Treinamento
Stes = size(dadosTes,2);     % Tamanho dos dados de Teste

a = 0.4;            % Taxa de aprendizado
epc = 0;
epocas = 150;

ev = ones(TrPares,Nclasses);   % Vetor de erros
Yf = zeros(TrPares, Nclasses); % Vetor de respostas
eqv = ones(epocas,1);

entTr = dadosTre;  alvoTr = classesTre;
entTe = dadosTes;  alvoTe = classesTes;

%% Se��o 4: Loop de Treinamento

while epc < epocas
   % A cada �poca, s�o apresentadas entradas em ordem randomizada.
   
  p = randperm(TrPares);  % Trpares n�meros naturais randomicos 
  entRand = entTr(:,p);   % Embaralha-se a ordem das entradas e alvos
  alvoRand = alvoTr(:,p);
  
    for i=1:TrPares
          X = entRand(:,i); % 4x1 
          T = alvoRand(:,i); % 3x1
          
          X1 = [1;X];    % Adi��o do multiplicador do Bias
          U1 = (Wa*X1);  % neu x 5 * 5 x 1 = neu x 1
          Y1 = F(U1);    % neu x 1
          
          % Adi��o do Multiplicador do Bias
          X2 = [1; Y1];  % (neu + 1) x 1
          U2 = Ma * X2; % [3 x (neu+1)] * [(neu+1) x 1] = 3x1
          Y2 = F(U2);   % 3x1 
          Yf(i,:) = Y2; 
          
          e = T - Y2;   % 3x1
          ev(i,:) = e'; 
          
          % Backpropagation por Regra Delta
          
          delta2 = e.*f(U2);  % 3x1      
          M_Delta = Ma(:,2:size(Ma,2)); % Remo��o do Bias
          % 3 x neu
          delta1 = (M_Delta'*delta2).*f(U1);
          % ([neu x 3] * [3 x 1] ).* (neu x 1)
          
          % Atualiza��o dos Pesos
          Wa = Wa + a*(delta1*X1'); % neu x 5 + [neu x 1]*[1 x 5]     
          Ma = Ma + a*(delta2*X2'); % [3 x neu+1] + [3 x 1] * [1 x neu+1]
    end
    
%     eqv(epc+1) = (1/(TrPares*2))*sum(sum((ev).^2)); % C�lculo do MSE
    epc = epc + 1;
    eqv(epc) = (1/(TrPares*2))*sum(sum((ev).^2)); % C�lculo do MSE
    
end

Y_resposta = round(Yf);

% Podemos plotar a evolu��o do MSE/EQM com as �pocas para ver 
% como o Treinamento se saiu.
figure (1)
l2 = linspace(0, epocas, epocas);
plot(l2, eqv)
title('�pocas x MSE na escala regular');
xlabel('�pocas');
ylabel('E(w)');


%% Se��o 5: Teste de Desempenho da Rede

TX1 = [ones(1, Stes);entTe]; % Adi��o do mult. do Bias
TU1 = Wa * TX1; 
TY1 = F(TU1);    

TX2 = [ones(1, Stes);TY1]; % Adi��o do mult. do Bias
TU2 = Ma * TX2;  
TY2 = F(TU2);    
Etes = alvoTe - TY2; % Calcula-se o erro

erro = trace(Etes*Etes')/(2*size(alvoTe, 2));
accTes = (1-(erro))*100

Y_class = round(TY2);

% Teste do Erro de Classifica��o: Porcentagem de Classes certas
ErroT = 0;

% Erro de Classifica��o: Se acertou ou errou as classes
for b=1:Stes
    if ~(isequal(alvoTe(:,b),Y_class(:,b)))
       ErroT = ErroT + 1; % Soma as classifica��es erradas
    end
end

ErroT_p = (ErroT/Stes); % Classifica��es erradas no teste 
accTp = (1-ErroT_p)*100 
N_acertos = accTp * 45 / 100
