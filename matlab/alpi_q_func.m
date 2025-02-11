function [value] = alpi_q_func(x)
  %function [value] = alpi_q_func(x)
  % Home made version of the matlab qfunc()
  % the normal qfunc() requires the communications toolbox...
  % http://www.mathworks.se/help/comm/ref/qfunc.html

  value = 1/2*erfc(x/sqrt(2));
end

