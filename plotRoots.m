function p = plotRoots(count, x)

	[w,a] = systemRoots(count, x)

	for index = 1:count-1
	
		omega = w(index+1)-500:0.01:w(index+1)+500;

		subplot (2, count-1, index);
		plot(omega, abs(1./stiffness(omega, x)));
		%fplot (@sin, [-10, 10]);
		subplot (2, count-1, count+index-1);
		%fplot (@cos, [-10, 10]);
		plot(omega, abs(stiffness(omega, x)));
	
	endfor

	fflush (stdout);

endfunction