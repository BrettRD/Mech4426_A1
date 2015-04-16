function [L,k,mostStiff] = optimise(L,k)

	%exponential L steps
	kbound = [5, 12]; %limit between 10^5 and 10^12
	%linear k steps
	L1 = 0.2;
	Lbound = [0, 2*L1]; % limit between 0 and twice L1
	
	Lstep = 0.01;
	kstep = 0.01;

	%initial conditions
	kExp = log10(k);
	mostStiff = betaM2(L,k);

	%Begin the search
	changed = true;
	while changed
		changed = false;

		%print the current values to the screen
		L
		k
		fflush(stdout);

		%try shifting L in the positive direction
		Ltest = min(L+Lstep,Lbound(2));
		testStiff = betaM2(Ltest,k);
		%store the higher of the results
		if (abs(testStiff)> abs(mostStiff))
			L=Ltest;
			mostStiff = testStiff;
			changed  = true;
		else
			%try shifting L in the negative direction
			Ltest = max(L-Lstep,Lbound(1));
			testStiff = betaM2(Ltest,k);
			%store the higher of the results
			if (abs(testStiff)> abs(mostStiff))
				L=Ltest;
				mostStiff = testStiff;
				changed  = true;
			endif
		endif

		%try shifting k in the positive direction
		ktestExp = min(kExp+kstep,kbound(2));
		ktest = 10^ktestExp;
		testStiff = betaM2(L,ktest);
		%store the higher of the results
		if abs(testStiff)> abs(mostStiff)
			kExp=ktestExp;
			k = ktest;
			mostStiff = testStiff;
			changed  = true;
		else	
			%try shifting k in the negative direction
			ktestExp = max(kExp-kstep,kbound(1));
			ktest = 10^ktestExp;
			testStiff = betaM2(L,ktest);
			%store the higher of the results
			if abs(testStiff)> abs(mostStiff)
				kExp=ktestExp;
				k = ktest;
				mostStiff = testStiff;
				changed  = true;
			endif
		endif

		%if we haven't made a change this cycle, we've either found the peak, or we're overstepping
		if((changed == false)&&(Lstep > 10^-7))
			%reduce step size
			kstep = kstep/2
			Lstep = Lstep/2
			changed = true;
			%draw and save some pretty pictures now that we've found an important value
			plotRoots(4, [L,k]);
		endif

	endwhile
	%draw the final values
	plotRoots(4, [L,k]);


endfunction
