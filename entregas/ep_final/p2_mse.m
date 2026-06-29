S = load('data/correl.mat');
X = S.X;          %entrada u(i)
Y = S.Y;          %saida d(i)
[R, N] = size(X); % R = 100 realizações, N = 15000 amostras
M = 31;           %ordem encontrada no item (a)
mu = 0.01;       
mse = zeros(N,1);

for r = 1:R
  u = X(r,:).'; 
  d = Y(r,:).';
  w = zeros(M,1);

  for n = M:N %comeca em M, pois precisamos de M amostras passadas
      ud = u(n:-1:n-M+1); % u na janela
      y = w.' * ud; % saída estimada
      e = d(n) - y; % erro 
      w = w + mu * e * ud; % Atualização do peso
      mse(n) = mse(n) + e^2;
  end

end

mse = mse / R;
figure;
plot(10*log(mse)/log(10),'LineWidth',2);
grid on;
xlabel('Iteração');
ylabel('MSE');
title('Curva de aprendizado - MSE(i), M=31');