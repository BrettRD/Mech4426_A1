function [omega, resStiffness, solnInfo] = systemRoots(count, x)
	%define the limits on the additional mass and damper
	L1 = 0.2;
	Llimit = [0, 2*L1];

	%initial conditions for the search
	L=x(1);
	k=x(2);

	omTol = 1;	%tolerance on omega values being the same root
	omStep = 500; %how large a step to make between initial conditions for fsolve

	%initialise some arrays
	omega(1:count) = 0;
	resStiffness(1:count) = 0;
	solnInfo(1:count) = 0;

	%omega(1) = 3000;  %There's a trivial root at zero, but we can skip ahead
	for n = 2:count

		omBegin = omega(n-1) +1;
		while (omega(n) < (omega(n-1)+omTol))
			
			%search for a resonant frequncy starting from omBegin
			REF = [L, k];
			f = @(y) reStiffness(y,REF); % function of dummy variable y
			[omega(n), resStiffness(n), solnInfo(n)] = fsolve(f,omBegin);

			%only accept solutions that converged neatly
			while ((solnInfo(n) == 0)||(solnInfo(n) == 2)||(solnInfo(n) == 3))
				[omega(n), resStiffness(n), solnInfo(n)] = fsolve(f,omega(n));
				%the following if rejects fsolve failures, but occasionally causes infinite loops
				%if (solnInfo(n) == -3)
				%	omega(n) = omega(n) - pi;
				%	solnInfo(n) = 0;
				%endif
			endwhile

			omBegin = omBegin + omStep;	%step the initial conditions forward
		
		endwhile
		%the value it fills with automatically used a trimmed stiffness value
		resStiffness(n) = stiffness(omega(n), [L,k])(1); %fetch the complex number from the raw stiffness value

	endfor
	
endfunction
