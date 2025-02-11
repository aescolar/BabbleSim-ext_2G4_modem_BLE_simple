function SNR_2 = SNRLossv2(SNR,NFigure,NoiseFloor)
  % SNR degradation produced internally by the receiver
  %
  % the input SNR (S/N) is transformed into
  % S/(NFigure*N + S*Nfloor) (in normal units)

  SNR = SNR - NFigure;
  N_u = 1./10.^((SNR)/10);
  N_u_o = N_u + 10.^(NoiseFloor/10) ;
  SNR_2 = 10*log10(1./N_u_o) ;
end

