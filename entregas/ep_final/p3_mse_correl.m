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
      ud = u(n:-1:n-M+1);
      y = w.' * ud;
      e = d(n) - y;
      w = w + mu * e * ud;
      mse(n) = mse(n) + e^2;
  end

end

mse = mse / R;
figure;
plot(mse,'LineWidth',2);
grid on;
xlabel('Iteração');
ylabel('MSE');
title('Curva de aprendizado - MSE(i), M=30');