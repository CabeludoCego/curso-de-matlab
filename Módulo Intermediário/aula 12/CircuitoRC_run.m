clear; close all; clc;
R = input('Resist�ncia: ');
C = input('Capacit�ncia: ');
Vo = input('Tens�o incial: ');
diagrama = sim("Circuito_RC");
plot(diagrama.tensao.Data)
title("Resposta natural do circuito RC");
xlabel("t");
ylabel("v(t)");