Desired_RxPower = -110:0.5:-90; %dBm

NoiseFigure = 3; %dB
ReceiverNoiseBW = 1.1e6; # BLE 1 MHz
ThermalNoisemW = 10^( (-174 + NoiseFigure)/10 ) * ReceiverNoiseBW; % -174dBm/Hz
SNR = Desired_RxPower - 10*log10(ThermalNoisemW);
#SNR = -10:18;

figure(1); #hold off;
semilogy(Desired_RxPower, digital_ber_coded(SNR, 0 ,1), "-*" ,"DisplayName", "BLE 1Mbps"); grid on; grid minor; ylim([10^-4 1]);
hold on;
xlabel("dBm"); ylabel("BER");

#Coded
CodedGain = [0, 4.5]; #S=2, S=8
Names = ["LR 500"; "LR 125"];
Coding_compression = 2;
for i=1:length(CodedGain),
  semilogy(Desired_RxPower, digital_ber_coded(SNR, CodedGain(i), Coding_compression), "-o", "DisplayName", Names(i,:));
endfor

#2M
ReceiverNoiseBW = 2.5e6;
ThermalNoisemW = 10^( (-174 + NoiseFigure)/10 ) * ReceiverNoiseBW; % -174dBm/Hz
SNR = Desired_RxPower - 10*log10(ThermalNoisemW);
semilogy(Desired_RxPower, digital_ber_coded(SNR, 0, 1), "-*", "DisplayName", "BLE 2Mbps");

HDTGain = [3, 0.5, -2.4, -6, -9.6];
Names = ["HDT2"; "HDT3"; "HDT4"; "HDT6"; "HDT7.5"];
Coding_compression = 3.2;
for i=1:length(HDTGain),
  semilogy(Desired_RxPower, digital_ber_coded(SNR, HDTGain(i), Coding_compression), "DisplayName", Names(i,:));
endfor
legend
#semilogy(-104:-99, [1.5e-1 7.5e-2 3.5e-2 1e-2 3.2e-3 3e-4 ]);

