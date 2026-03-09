% 1. Carregar o arquivo de áudio
% Substitua 'seu_audio.wav' pelo nome do seu arquivo
[y, fs] = audioread('/home/jvcm/Projetos/karaokay/audio/Eddies_Twister.wav');

% Se o áudio for estéreo, converter para mono pegando a média dos canais
if size(y, 2) > 1
    y = mean(y, 2);
end

% 2. Preparar os parâmetros da FFT
n = length(y);          % Número de amostras
f = (0:n-1)*(fs/n);     % Vetor de frequências

% 3. Calcular a FFT
Y = fft(y);

% Calcular a magnitude (absoluto) e normalizar
% Pegamos apenas a primeira metade, pois a FFT é simétrica
mag = abs(Y(1:floor(n/2)+1));
f_plot = f(1:floor(n/2)+1);

% 4. Plotar os resultados
subplot(2,1,1);
plot((1:n)/fs, y);
title('Sinal no Domínio do Tempo');
xlabel('Tempo (s)');
ylabel('Amplitude');

subplot(2,1,2);
plot(f_plot, mag);
title('Sinal no Domínio da Frequência (Magnitude)');
xlabel('Frequência (Hz)');
ylabel('Magnitude');
grid on;
