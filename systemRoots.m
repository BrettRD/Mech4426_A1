function [omega, displacement, solnInfo] = systemRoots(count, x)
	%define the limits on the additional mass
	L1 = 0.2;
	Llimit = [0, 2*L1];

	%initial conditions for the search
	L=x(1);
	k=x(2);

	omTol = 1;	%tolerance on omega values being the same root
	omStep = 100;

	omega(1:count) = 0;
	displacement(1:count) = 0;
	solnInfo(1:count) = 0;

	%increase the beginning omega so we don't wait so long
	omega(1) = 3000;
	for n = 2:count

		omBegin = omega(n-1) +1;
		while (omega(n) < (omega(n-1)+omTol))
			
			%search for a resonant frequncy starting from omBegin
			REF = [L, k];
			f = @(y) reStiffness(y,REF); % function of dummy variable y
			[omega(n), displacement(n), solnInfo(n)] = fsolve(f,omBegin);

			%The fsolve function has all sorts of bullshit reasons to quit. 
			%if you don't have a solution, go back and do it again!
			%while (solnInfo(n) == 0)
			%while ((solnInfo(n) == 0)||(solnInfo(n) == 3))
			while ((solnInfo(n) == 0)||(solnInfo(n) == 2)||(solnInfo(n) == 3))
			%while (solnInfo(n) != 1)
				[omega(n), displacement(n), solnInfo(n)] = fsolve(f,omega(n));
				%the following if throws infinite loops occasionally
				%if (solnInfo(n) == -3)
				%	omega(n) = omega(n) - pi;
				%	solnInfo(n) = 0;
				%endif

			endwhile

			omBegin = omBegin + omStep;
		
		endwhile
		%the value it fills with automatically doesn't include the complex coefficients
		%displacement(n) = systemBeta(omega(n), [L,k]);
		%displacement(n) = systemBeta(omega(n), [L,k]);
		displacement(n) = stiffness(omega(n), [L,k])(1);

	endfor
	
	%Maximise2D(systemBeta(omega[2], L, k))

endfunction
