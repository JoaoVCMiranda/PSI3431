function M_testes = gerar_M_testes(valor_inicio, intervalo, vezes)
   M_testes = valor_inicio + (0:vezes-1) *intervalo;
end

S = load("data/whites.mat");
X = S.X; % entrada u(i)
Y = S.Y; % saída d(i)
[R, N] = size(X); % R = 100 realizações, N = 15000 amostras
mu = 0.01; % passo de adaptação
M_testes = gerar_M_testes(5, 5, 20); % busca de 5 a 100
%M_testes = gerar_M_testes(25, 1, 10);

janela = 0.2*N; % usamos os últimos 20% amostras como regime estacionario
mseFinal = zeros(size(M_testes));

for i  = 1:length(M_testes)

    M = M_testes(i);
    mse = zeros(N,1);
    for r = 1:R
           u = X(r,:).';
           d = Y(r,:).';
           w = zeros(M,1);
    
           for n = M:N  % o mse adota as últimas janela = 0.2*15000 = 3000 amostras
                   ud = u(n:-1:n-M+1); % últimas M amostras (começa pelo mais recente)
                   y = w.' * ud;
                   e = d(n) - y;
                   w = w+ mu * e * ud;
                   mse(n) = mse(n) + e^2;
           end
    end

    mse = mse/R;
    mseFinal(i) = mean(mse(N-janela+1:N));
end

figure;
plot(M_testes, mseFinal,'LineWidth',2);
grid on;
xlabel('Ordem M testada');
ylabel('MSE (regime estacionário)');
title('Estimativa da ordem M - busca ampla (M = 5 a 100)'); %busca de 5 a 100
%title('Estimativa da ordem M - refinamento (M = 25 a 34)'); %busca de 25 a 35