function omega = optimise()
	%define the limits on the additional mass
	L1 = 0.2;
	Llimit = [0, 2*L1];

	%initial conditions for the search
	L=0.2;
	k=1;

	omTol = 1;	%tolerance on omega values being the same root
	omStep = 10;
	%increase the beginning omega 
	omega(1:6) = 0;
	%w = 1:0.1:100;
	%REF = [L, k];
	%f = @(y) stiffness(y,REF); % function of dummy variable y
	%plot(w, w.^2)

	for n = 2:6
		omBegin = omega(n-1) +1
		while (omega(n) < (omega(n-1)+omTol))
			
			%search for a resonant frequncy starting from omBegin
			REF = [L, k];
			f = @(y) stiffness(y,REF); % function of dummy variable y
			omega(n) = fsolve(f,omBegin);
			%sometimes the fsolve routine runs into NaN results and aborts. Running it again seems to fix that.
			omega(n) = fsolve(f,omega(n));

			omBegin = omBegin + omStep;
		
			%REF = [L,k];
			%f = @(y) stiffness(y,REF); % function of dummy variable y
			%[omega,fval,info]=fsolve(f,y0);

		endwhile

	endfor
	

	%Maximise2D(systemBeta(omega[2], L, k))

endfunction
