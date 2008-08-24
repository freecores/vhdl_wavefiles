clear all;
close all;

fs = 1e9;
% frequence, amplitude
Sinus = [6e6, 0.6];
lf = [1e6, 0.8];
noise = 0.2;
bits = 9;
t = 2e-6;

LF = SinGen(fs,t, lf);
S =  SinGen(fs,t, Sinus);

InputValues = [LF S]';
Mono = InputValues/(max(InputValues)+0.02);

wavwrite(Mono,1e6,8,'iMono.wav');

Stereo = [Mono Mono];
wavwrite(Stereo, 44100,16,'iStereo.wav');

z = rand(length(InputValues(:,1)),8);
Ch10 = [z Stereo];
wavwrite(Ch10, 1e9,16,'iCh10.wav');
plot(InputValues(:,1));

wavwrite(Stereo, 1e5,32,'iBit32.wav');
plot(InputValues(:,1));

