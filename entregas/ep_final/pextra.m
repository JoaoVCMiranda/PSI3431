% botando pra fuder
function fuder(r, u, d, w_est, E, mse , w, M, N)
  sgtitle(sprintf('Realização %d Janela %d', r, w));
  
  subplot(4,4,[1,2]);
  plot(1:N,u);
  patch([w-M+1 w-M+1 w w], [-5 5 5 -5], 'green');

  subplot(4,4,[5,6]);
  plot(1:N,d);
  patch([w-M+1 w-M+1 w w], [-5 5 5 -5], 'green');

  subplot(4,4,[3,4,7,8]);
  stem(w_est/r,'LineWidth',2);

  subplot(4,4,[13,16])
  plot(1:N-M+1, 10*log(E/r)/log(10),'LineWidth',2);
  yline(sum(E)/(w-M+1), '--');
  grid on;
  xlabel('Iteração');
  ylabel('SE');

  subplot(4,4,[9,12])
  plot(1:N,10*log(mse/r)/log(10),turbo(floor(r*(64/100))),'LineWidth',2);
  grid on;
  xlabel('Iteração');
  ylabel('MSE');
    
  saveas(gcf, sprintf('img/realizacao_%d_window_%d.png',r,w))
end

S = load("data/correl.mat");
X = S.X;          %entrada u(i)
Y = S.Y;          %saida d(i)
% sabemos a ordem da planta, M=31
[R, N] = size(X); % R = 100 realizações, N = 15000 amostras

M = 31;           %ordem encontrada no item (a)
mu = 0.01;       
mse = zeros(N,1);
w_est = zeros(M,1);

for r = 1:R
  u = X(r,:).';

  d = Y(r,:).';

  w = zeros(M,1);
  E = zeros(N-M+1, 1);
  for n = M:N
      ud = u(n:-1:n-M+1); % u na janela
      y = w.' * ud; % saída estimada
      e = d(n) - y; % erro 
      w = w + mu * e * ud; % Atualização do peso
      E(n-M+1)=e^2;
      mse(n) = mse(n) + e^2;

      fuder(r, u, d, w_est, E, mse , n, M, N);
  end
  w_est = w_est + w;
end