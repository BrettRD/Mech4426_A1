function dynStiff = stiffness(omega, x)
    L2 = x(1);
    k = x(2);
    omega = real(omega);

    %Mechanical dimensions
    D1 = 0.12;
    D2 = 0.07;
    L1 = 0.2;
    %Material Properties
    alpha = 0.4;
    G=8*(10^10);
    rho = 7800;
    

    Dc = 2*D1;
    Db = D1;
    Lc = L1;
    Lb = 5*L1;

    Jc = pi * Dc/32;
    Jb = pi * Db/32;
    J2 = pi * D2/32;
    lamda = rho*(omega^2)/G;

    betaDamper = (1/(k*(1+i*alpha)));
    betaMass = -(cos(lamda*L2)/(G*J2*lamda*sin(lamda*L2)));
    
    betaBar = -(cos(lamda*Lb)/(G*Jb*lamda*sin(lamda*Lb)));
    
    betaStub = -(cos(lamda*Lc)/(G*Jc*lamda*sin(lamda*Lc)));
    betaCross = -1/(G*Jb*lamda*sin(lamda*Lb));
    betaLeft = betaBar - ((betaCross^2)/(betaStub+betaBar));

    %betaStub = 1/(((G*Jb*lamda*sin(lamda*Lb))^2) * (((cos(lamda*Lb))/((G*Jb*lamda*sin(lamda*Lb))))+((cos(lamda*Lc))/((G*Jc*lamda*sin(lamda*Lc))))) );
    %betaLeft = betaBar + betaStub;
    %sum receptances
    

    
    

    betaRight = betaDamper + betaMass;

    %sum stiffnesses:
    dynStiff = (1/(betaLeft)) + (1/(betaRight));



endfunction

%function dynStiff = stiffness(omega, x)
%    dynStiff =  real(1/systemBeta(real(omega), x));
%endfunction
