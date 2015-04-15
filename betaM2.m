function betaMode2 = betaM2(L,k)
	[w,a,solnInfo] = systemRoots(3, [L,k]);
	betaMode2 = 0;
	if(solnInfo(3) == 1)
		betaMode2 = a(3);
	endif

endfunction
