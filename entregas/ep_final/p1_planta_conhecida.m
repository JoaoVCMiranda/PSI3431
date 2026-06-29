wo = [-0.5247; -0.2060; 0.3324; -0.2631; 0.2358; 0.0304; 0.3525; -0.4812; -0.0485; -0.2964];

M = length(wo);
N = 500;           %número de iterações - semelhante ao batch_length de redes neurais
R = 1000;          %realizações - semelhante ao epochs de redes neurais, mas independentes entre si
mu = 0.01;         %passo de adaptação
mse = zeros(N,1);
emse = zeros(N,1);

for r = 1:R
   x = randn(N+M-1,1);   %entrada branca
   w = zeros(M,1);       %inicializando os pesos

   for n = 1:N %lembrando que, no MATLAB, o primeiro indice é 1!
       %nota: a.' é o vetor transposto de a
       %nota2: na linha a seguir, u = x(inicio:passo:fim), mas os
       %componentes do vetor w devem estar alinhados com os componentes da
       %entrada x de trás para frente, dada a fórmula do LMS
       u = x(n+M-1:-1:n);   
       d = wo.' * u;                            
       y = w.' * u;         
       e = d - y;           
       w = w + mu * e * u;  
          
       %acúmulo dos erros a cada iteração. No final, divide-se por R para
       %determinar o erro médio
       mse(n) = mse(n) + e^2;
       %vale o mesmo para o erro em excesso
       emse(n) = emse(n) + ((wo - w).' * u)^2;
   end

end

mse = mse / R;
emse = emse / R;

figure;
plot(mse,'LineWidth',2);
grid on;
xlabel('Iteracao');
ylabel('MSE');
title('Curva de aprendizado - MSE');
figure;
plot(emse,'LineWidth',2);
grid on;
xlabel('Iteration');
ylabel('EMSE');
title('Curva de aprendizado - EMSE');