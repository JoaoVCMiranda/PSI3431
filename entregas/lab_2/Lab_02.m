%% Setup
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Nome: Jose Maria da Silva   %
% NUSP: 1324576               %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clear all;
close all;

num_usp=10336021;

%Gerando requerimentos da mascara //// NAO MODIFICAR ////
spec_vec=MagicBox(num_usp);
A_p = spec_vec(1); %dB
A_sb = spec_vec(2); %dB
f_p = spec_vec(3); %Hz
f_sb = spec_vec(4); %Hz

%Gerando sinal base //// NAO MODIFICAR ////
real_time = 3;
Fs=400.0;
t=0:round(real_time*Fs)-1;

f_l=10.0;
f_h=150.0;

s=0.5*sin(2*pi*f_l*t/Fs+3*pi/4)+0.5*cos(2*pi*f_h*t/Fs-pi/2)+sqrt(10^(-3))*randn(size(t));

%% Seu Codigo comeca aqui
