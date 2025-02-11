function BER = digital_ber_coded(SNR, Coding_gain, Coding_compression)
  # The Coding_compression parameter is an "empirically" guessed value which tries
  # to fit the fact that coding makes the BER curve steeper, and does so more
  # the higher the convolutional code constraint length.
  # Therefore Coding_compression scales the ("x axis" == SNR) by that factor.
  # The Coding_gain parameter accounts for the actual coding gain, but should discount
  # the effect the Coding_compression also has on bringing the curve closer to 0dB SNR

  NFigure = 2; %in dB, extra noise figure of the digital demodulation path
  NoiseFloor = -35; %in dB, maximum SNR (equivalent to a quantization noise)
  SNR_i = SNRLossv2(SNR,NFigure,NoiseFloor);

  tmp = 10.^((SNR_i + Coding_gain)/20); %/20 instead of 10 to get the sqrt();
  BER = alpi_q_func(tmp.^Coding_compression);
end

