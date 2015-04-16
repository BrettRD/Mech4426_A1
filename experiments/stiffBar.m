function s = stiffBar(lambda, G, J, L)
	s(2,2) = 0;
	%dynamic stiffness of the bar at a either end
	s(1,1) = - G*J*lambda * (sin(lambda*L)/cos(lambda*L));
	s(2,2) = - G*J*lambda * (sin(lambda*L)/cos(lambda*L));
	%the stiffness cross-terms 
	s(1,2) = G*J*lambda * sin(lambda*L);
	s(2,1) = G*J*lambda * sin(lambda*L);
endfunction

%I'm tending to use dynamic stiffness in preference to receptance because it lets me avoid various singularities.
