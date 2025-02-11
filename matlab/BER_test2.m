# Copyright Oticon A/S 2018
# SPDX-License-Identifier: Apache-2.0

function [] = BER_test2()
%script to test the BER calculation of the C model (second part of test_ber.c)

  load ../src/test/BER.txt
  level = BER(:,1);
  SNR = BER(:,2);
  BER = BER(:,3);
  
  BER_2 = zeros(size(level));
  
  ModulationRx = 'modulation_BLE';
  CenterFreq = 2450e6;
  clear ListInter
  ListInter = {};

  if 0, #BLE uncoded (2Mbps)
    Coding_Gain = 0;
    Coding_compression = 1;
  elseif 0, #BLE uncoded (2Mbps)
    Coding_Gain = 0;
    Coding_compression = 1;
    ModulationRx = 'modulation_Prop2M';
  elseif 0, #BLE coded S=2
    Coding_Gain = 0;
    Coding_compression = 2;
  elseif 0, #BLE coded S=8
    Coding_Gain = 4.5;
    Coding_compression = 2;
  elseif 0, #BLE HDT2
    Coding_Gain = 3;
    Coding_compression = 3.2;
    ModulationRx = 'modulation_Prop2M';
  elseif 0, #BLE HDT3
    Coding_Gain = 0.5;
    Coding_compression = 3.2;
    ModulationRx = 'modulation_Prop2M';
  elseif 0, #BLE HDT4
    Coding_Gain = -2.4;
    Coding_compression = 3.2;
    ModulationRx = 'modulation_Prop2M';
  elseif 0, #BLE HDT6
    Coding_Gain = -6;
    Coding_compression = 3.2;
    ModulationRx = 'modulation_Prop2M';
  elseif 1, #BLE HDT7.5
    Coding_Gain = -9.6;
    Coding_compression = 3.2;
    ModulationRx = 'modulation_Prop2M';
  endif

  for level_i = level',
    Desired.RxPower = level_i;
    [SNR, ~] = analog_model( ListInter, Desired, ModulationRx, CenterFreq );
    BER_2(level_i==level) = digital_ber_coded(SNR, Coding_Gain, Coding_compression);
  end
  figure(10); clf;
  semilogy(level,BER,'r'); hold on;
  semilogy(level,BER_2,'b'); grid on;
  ylim([10^-8 1]); xlabel('dBm'); ylabel('BER');
  xlim([-110 -90]);
end

