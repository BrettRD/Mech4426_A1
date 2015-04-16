function b = betaDamper(k, alpha)
	%this one needs to be in receptance form. Because the system is massless, the forces on both ends must be identical.
	%because of this, the system is non-invertible
	b(2,2) = 0;
	
	b(1,1) =  1/(k*(1+i*alpha));
	b(2,1) =  1/(k*(1+i*alpha));
	b(1,2) = -1/(k*(1+i*alpha));
	b(2,2) = -1/(k*(1+i*alpha));
endfunction

%I'm tending to use dynamic stiffness in preference to receptance because it lets me avoid various singularities.
