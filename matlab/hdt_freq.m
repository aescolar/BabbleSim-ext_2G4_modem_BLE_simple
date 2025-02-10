# First very quick generation of the HDT signal spectrum and of a good-enough by now Rx filter response

# Shape of a HDT signal spectrum (just done as the theoretical HDT RRC)
# Shape of the combined HDT Rx filter: A wild guess of how that could look in a real modem

fres = 200e3;

## Shape of a HDT signal spectrum

T = 0.5e-6;
b = 0.4;
flim = 2e6; #(1 + b)/(2*T);
rlim2 = (1 + b)/(2*T);
rlim = (1 - b)/(2*T);

f = -flim:fres:flim;
P = ones(size(f));
P2 = sqrt(1/2*(1-sin(pi*(2*abs(f)*T-1)/(2*b))));
P(f > rlim) = P2(f > rlim);
P(f < -rlim) = P2(f < -rlim);
P(f < -rlim2 | f > rlim2) = 0;
# P is the theoretical RRC filter shape (amplitude) in freq. domain

Po = P.^2;
Po = Po ./sum(Po); #Po is just P in powwer scaled to a total power of 1

Pi = zeros(size(f));
Pi_h = [0	0	0	-0.7	-3.05	-8.4	-37	-41	-44 -48]; #"Hand drawn" approximate spectrum (in dBs)
Pi = [Pi_h(end:-1:1) 0 Pi_h]; clear Pi_h
Pi_nu = 10.^(Pi./10);
Pi_nu = Pi_nu / sum(Pi_nu);
Pi_nu # Shape of modulation for HDT (power in n.u.)

figure(5);
hold off;
#plot(f,20*log10(P));
plot(f,10*log10(Po));
hold on; grid on;
plot(f,10*log10(Pi_nu));

clear Pi Po P P2 rlim rlim2 T b flim


## Quick cross check of old Rx filters (BLE 1 & 2Mbps)

BLE = [4.1980e-05,   2.8516e-04,   4.8379e-04,   1.2872e-02,   9.1159e-02,...
    2.4433e-01,   3.0165e-01,   2.4433e-01,   9.1159e-02,   1.2872e-02,...
    4.8379e-04,   2.8516e-04,   4.1980e-05];
BLEf = [1.0000e-06,   1.2589e-06,   1.5849e-06,   1.9953e-06,   2.5119e-06,...
    3.1623e-06,   5.0119e-06,   1.0000e-05,   3.1623e-05,   1.0000e-04,...
    3.1623e-04,   1.0000e-03,   3.1623e-03,   1.0000e-02,   3.9811e-02,...
    1.1398e-01,   2.6304e-01,   6.7212e-01,   7.9446e-01,   9.8531e-01,...
    1.1791e+00,   9.8531e-01,   7.9446e-01,   6.7212e-01,   2.6304e-01,...
    1.1398e-01,   3.9811e-02,   1.0000e-02,   3.1623e-03,   1.0000e-03,...
    3.1623e-04,   1.0000e-04,   3.1623e-05,   1.0000e-05,   5.0119e-06,...
    3.1623e-06,   2.5119e-06,   1.9953e-06,   1.5849e-06,   1.2589e-06,...
    1.0000e-06];
fBLEf = (-(length(BLEf)-1)/2:(length(BLEf)-1)/2)*fres;
fBLE = (-(length(BLE)-1)/2:(length(BLE)-1)/2)*fres;
Overlap = BLEf(fBLEf >= min(fBLE) & fBLEf <= max(fBLE));
check = sum((sqrt(Overlap).*sqrt(BLE)).^2);

clear BLE BLEf fBLE fBLEf Overlap check

#plot(fBLEf, 10*log10(BLEf)); hold on;
#plot(fBLE, 10*log10(BLE));
#
Prop2 = [...
1.4055e-05,   5.6012e-05,   1.5134e-04,   2.1890e-04,   1.2972e-04,...
    3.2762e-04,   3.3251e-03,   1.4459e-02,   4.1335e-02,   8.0105e-02,...
    1.1656e-01,   1.5506e-01,   1.7652e-01,   1.5506e-01,   1.1656e-01,...
    8.0105e-02,   4.1335e-02,   1.4459e-02,   3.3251e-03,   3.2762e-04,...
    1.2972e-04,   2.1890e-04,   1.5134e-04,   5.6012e-05,   1.4055e-05];
Prop2f = [...
    1.0000e-06,   1.5849e-06,   2.5119e-06,   3.9811e-06,   6.3096e-06,...
    7.9433e-06,   1.0000e-05,   1.2589e-05,   1.5849e-05,   1.9953e-05,...
    2.5119e-05,   3.1623e-05,   3.9811e-05,   5.0119e-05,   6.3096e-05,...
    7.9433e-05,   1.0000e-04,   1.2589e-04,   1.5849e-04,   1.9953e-04,...
    2.5119e-04,   3.1623e-04,   3.9811e-04,   5.0119e-04,   6.3096e-04,...
    1.0000e-03,   1.5849e-03,   3.1623e-03,   6.3096e-03,   3.1565e-02,...
    5.2087e-02,   6.4973e-02,   1.3748e-01,   2.0369e-01,   4.3440e-01,...
    8.5992e-01,   1.0097e+00,   1.0097e+00,   1.0097e+00,   1.0097e+00,...
    1.0097e+00,   1.0097e+00,   1.0097e+00,   1.0097e+00,   1.0097e+00,...
    8.5992e-01,   4.3440e-01,   2.0369e-01,   1.3748e-01,   6.4973e-02,...
    5.2087e-02,   3.1565e-02,   6.3096e-03,   3.1623e-03,   1.5849e-03,...
    1.0000e-03,   6.3096e-04,   5.0119e-04,   3.9811e-04,   3.1623e-04,...
    2.5119e-04,   1.9953e-04,   1.5849e-04,   1.2589e-04,   1.0000e-04,...
    7.9433e-05,   6.3096e-05,   5.0119e-05,   3.9811e-05,   3.1623e-05,...
    2.5119e-05,   1.9953e-05,   1.5849e-05,   1.2589e-05,   1.0000e-05,...
    7.9433e-06,   6.3096e-06,   3.9811e-06,   2.5119e-06,   1.5849e-06,...
    1.0000e-06];
fProp2f = (-(length(Prop2f)-1)/2:(length(Prop2f)-1)/2)*fres;
#figure(10); plot(fProp2f, 10*log10(Prop2f));
fProp2 = (-(length(Prop2)-1)/2:(length(Prop2)-1)/2)*fres;
Overlap = Prop2f(fProp2f >= min(fProp2) & fProp2f <= max(fProp2));
check = sum((sqrt(Overlap).*sqrt(Prop2)).^2);

clear Prop2 Prop2f fProp2 fProp2f Overlap check

## Shape of the combined HDT Rx filter

HDTf_h = [
#0.2  0.4  0.6  0.8  1.0  1.2  1.4  1.6  1.8  2.0  2.2  2.4  2.6  2.8  3.0  3.2  3.4  3.6  3.8  4.0  4.2  4.4  4.6  4.8
   0   0    0  -0.7 -3.05 -8.4 -28  -30  -32  -36  -37  -38  -39  -40  -42  -44  -46  -48  -50  -52  -54  -56  -58  -60
];
HDTf = [HDTf_h(end:-1:1) 0 HDTf_h];
clear HDTf_h

HDTf_nu = 10.^(HDTf./10);
HDTf_nu = HDTf_nu / sum(HDTf_nu);
%TODO: Scale for gain 1 with Pi_nu
fHDTf = (-(length(HDTf)-1)/2:(length(HDTf)-1)/2)*fres;

Overlap = HDTf_nu(fHDTf >= min(f) & fHDTf <= max(f));
acc = sum((sqrt(Overlap).*sqrt(Pi_nu)).^2);
HDTf_nu = HDTf_nu./acc;

Overlap = HDTf_nu(fHDTf >= min(f) & fHDTf <= max(f));
check = sum((sqrt(Overlap).*sqrt(Pi_nu)).^2);

figure(1); hold off; plot(fHDTf, 10*log10(HDTf_nu)); hold on; grid on;
plot(f, 10*log10(Pi_nu));

