# Copyright Oticon A/S 2018
# SPDX-License-Identifier: Apache-2.0

function BER = digital_ber(SNR)

  NFigure = 2; %in dB, extra noise figure of the digital demodulation path
  NoiseFloor = -35; %in dB, maximum SNR (equivalent to a quantization noise)

  SNR_i = SNRLossv2(SNR,NFigure,NoiseFloor);

  tmp = 10.^(SNR_i/20); %/20 instead of 10 to get the sqrt();
  BER = alpi_q_func(tmp);
end

