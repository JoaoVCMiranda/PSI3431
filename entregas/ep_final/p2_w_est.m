S = load('data/whites.mat');
X = S.X;       
Y = S.Y;         
[R, N] = size(X);
M = 31;          
mu = 0.01;       
w_est = zeros(M,1);

for r = 1:R
  u = X(r,:).';  
  d = Y(r,:).'; 
  w = zeros(M,1);

  for n = M:N
      ud = u(n:-1:n-M+1);
      y = w.' * ud;
      e = d(n) - y;
      w = w + mu * e * ud;
  end
  %após N iteracoes, w ja convergiu (regime estacionario);
  w_est = w_est + w;
end

w_est = w_est / R;
disp('Vetor estimado (w_est):');
disp(w_est);
figure;
stem(w_est,'LineWidth',2);
grid on;
xlabel('Indice do coeficiente');
ylabel('Valor estimado');
title('Vetor estimado (M=31)');