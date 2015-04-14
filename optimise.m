function [L,k,amp] = optimise(L,k)
	%define the limits on the additional mass
	L1 = 0.2;
	Llimit = [0, 2*L1];

	%initial conditions for the search
	L=x(1);
	k=x(2);

	Diff(2) = 0;

	%exponential L steps
	Lbound = [5, 12];
	Lstep = 0.1;

	%linear k steps
	kbound = [0, 0.4];
	kstep = 0.01

	mostStiff = betaMode2()

	%I don't know
	bool changed = true;

	while changed
		%find the second root given L and k
		%make a small change to L and k, calculate the amplitude of the second mode for each
		%store the results of those tests as a vector
		%Use the test results as a step vector?
		amp = betaM2(L,k);
		changed = false;
		plotRoots(4, [L,k]);
		fflush(stdout);


		for ktest = kbound(1):kstep:kbound(2)
			testStiff = betaM2(L,ktest);
			if abs(testStiff)>abs(mostStiff)
				k=ktest;
				mostStiff = testStiff;
				changed  = true;
			endif
		endfor

		for LtestExp = Lbound(1):Lstep:Lbound(2)
			Ltest = 10^LtestExp;
			testStiff = betaM2(Ltest,k);
			if abs(testStiff)>abs(mostStiff)
				L=Ltest;
				mostStiff = testStiff;
				changed  = true;
			endif
		endfor


	endwhile
	


endfunction
