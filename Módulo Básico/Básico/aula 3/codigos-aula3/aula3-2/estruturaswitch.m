clc
clear
disp('CADASTRO DE INFORMA��ES');
nome = input('Digite seu nome: ','s');
idade = input('Digite sua idade: ');
curso = input('Digite seu curso: ','s');
resposta = input('Deseja imprimir informa��es cadastradas? Digite SIM ou N�O.\n','s');
S = lower(resposta);
switch (S)
    case {'s','si','sim'}
        fprintf('Nome: %s\n',nome);
        fprintf('Idade: %d\n',idade);
        fprintf('Curso: %s\n',curso);
    case {'n','na','nao','n�','n�o'}
        fprintf('Seus dados foram cadastrados com sucesso!\n');
    otherwise
        fprintf('Falha!\n');
end    