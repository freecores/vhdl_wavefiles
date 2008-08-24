
[M fs] = wavread('oMono.wav');
Monox = sum(M-Mono);
figure
hold on
plot(Mono);
plot(M);
plot(M-Mono);
hold off

[S fs] = wavread('oStereo.wav');
Stereox = sum(sum(S-Stereo));
figure
hold on
plot(Stereo(:,2));
plot(S(:,2));
plot(S(:,2)-Stereo(:,2));
hold off

[C fs] = wavread('oCh10.wav');
Ch10x = sum(sum(C-Ch10));
figure
hold on
plot(Ch10(:,9));
plot(C(:,9));
plot(C(:,10)-Ch10(:,10));
hold off

[B fs] = wavread('oBit32.wav');
Bit32x = sum(sum(C-Ch10));
figure
hold on
plot(Stereo(:,2));
plot(B(:,2));
plot(B(:,2)-Stereo(:,2));
hold off
