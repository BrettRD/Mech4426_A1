function dynStiff = stiffness(omega, x)
    %variables to optimise
    L2 = x(1);
    k = x(2);
    %complex omega confuses fsolve
    omega = real(omega);

    %Given mechanical dimensions
    D1 = 0.12;
    D2 = 0.07;
    L1 = 0.2;

    %Material Properties
    alpha = 0.4;
    G=8*(10^10);
    rho = 7800;
    
    %component dimensions
    Dc = 2*D1;
    Db = D1;
    Lc = L1;
    Lb = 5*L1;

    Jc = pi * Dc/32;
    Jb = pi * Db/32;
    J2 = pi * D2/32;

    %Frequency
    lamda = rho*(omega.^2)/G;

    %Receptances of the parts
    %To the right
    betaDamper = (1/(k*(1+i*alpha)));
    betaMass = -(cos(lamda.*L2)./(G*J2*lamda.*sin(lamda.*L2)));
    %To the left
    betaBar = -(cos(lamda*Lb)./(G*Jb*lamda.*sin(lamda.*Lb)));
    betaStub = -(cos(lamda.*Lc)./(G*Jc*lamda.*sin(lamda.*Lc)));
    betaCross = -1./(G*Jb*lamda.*sin(lamda.*Lb));

    %combine the parts
    betaLeft = betaBar - ((betaCross.^2)./(betaStub+betaBar));
    betaRight = betaDamper + betaMass;

    %sum stiffnesses:
    dynStiff(3, :) = 1./(betaRight);
    dynStiff(2, :) = 1./(betaLeft);
    dynStiff(1, :) = (1./(betaLeft)) + (1./(betaRight));

endfunction

