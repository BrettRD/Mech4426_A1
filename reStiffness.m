function dynStiff = reStiffness(omega, x)
    dynStiff = real(stiffness(omega, x)(1));
endfunction
