function [L,k,mostStiff] = optimise(L,k)
	%define the limits on the additional mass
	L1 = 0.2;

	%exponential L steps
	kbound = [5, 12];
	kstep = 0.01;
	kExp = log10(k);
	%linear k steps
	Lbound = [0, 2*L1];
	Lstep = 0.001;

	mostStiff = betaM2(L,k)

	changed = true;

	while changed
		%find the second root given L and k
		%make a small change to L and k, calculate the amplitude of the second mode for each
		%store the results of those tests as a vector
		%Use the test results as a step vector?
		changed = false;

		plotRoots(4, [L,k]);
		drawnow
		L
		k
		fflush(stdout)

		Ltest = min(L+Lstep,Lbound(2));
		testStiff = betaM2(Ltest,k);
		if (abs(testStiff)> abs(mostStiff))
			L=Ltest;
			mostStiff = testStiff;
			changed  = true;
		endif
		
		Ltest = max(L-Lstep,Lbound(1));
		testStiff = betaM2(Ltest,k);
		if (abs(testStiff)> abs(mostStiff))
			L=Ltest;
			mostStiff = testStiff;
			changed  = true;
		endif




		plotRoots(4, [L,k]);
		drawnow
		L
		k
		fflush(stdout);

		ktestExp = min(kExp+kstep,kbound(2));
		ktest = 10^ktestExp;
		testStiff = betaM2(L,ktest);
		if abs(testStiff)> abs(mostStiff)
			kExp=ktestExp;
			k = ktest;
			mostStiff = testStiff;
			changed  = true;
		endif
		
		ktestExp = max(kExp-kstep,kbound(1));
		ktest = 10^ktestExp;
		testStiff = betaM2(L,ktest);
		if abs(testStiff)> abs(mostStiff)
			kExp=ktestExp;
			k = ktest;
			mostStiff = testStiff;
			changed  = true;
		endif


	endwhile
	


endfunction
